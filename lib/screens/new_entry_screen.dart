import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/journal_entry.dart';
import '../providers/journal_provider.dart';
import '../theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class NewEntryScreen extends StatefulWidget {
  final JournalEntry? existingEntry;

  const NewEntryScreen({super.key, this.existingEntry});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String selectedMood = 'Tenang';
  String selectedTag = 'syukur';
  final List<String> tags = ['syukur', 'pertumbuhan', 'kerja', 'istirahat'];
  Uint8List? _imageBytes;

  final List<Map<String, String>> moods = [
    {'name': 'Tenang', 'emoji': '🌿', 'color': 'leaf'},
    {'name': 'Senang', 'emoji': '✨', 'color': 'bulb'},
    {'name': 'Melankolis', 'emoji': '🌊', 'color': 'wave'},
    {'name': 'Energi', 'emoji': '⚡', 'color': 'lightning'},
    {'name': 'Marah', 'emoji': '☁️', 'color': 'moon'},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingEntry != null) {
      _titleController.text = widget.existingEntry!.title;
      _contentController.text = widget.existingEntry!.content;
      selectedMood = moods.firstWhere((m) => m['emoji'] == widget.existingEntry!.emoji, orElse: () => moods.first)['name']!;
      selectedTag = widget.existingEntry!.category;
      if (!tags.contains(selectedTag)) {
        tags.add(selectedTag);
      }
      _imageBytes = widget.existingEntry!.imageBytes;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  void _showAddTagDialog() {
    final TextEditingController tagController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.backgroundColor,
          title: const Text('Tambah Tag Baru', style: TextStyle(color: AppTheme.textColor)),
          content: TextField(
            controller: tagController,
            decoration: InputDecoration(
              hintText: 'Nama tag...',
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.primaryColor)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                final tag = tagController.text.trim().toLowerCase();
                if (tag.isNotEmpty && !tags.contains(tag)) {
                  setState(() {
                    tags.add(tag);
                    selectedTag = tag;
                  });
                } else if (tags.contains(tag)) {
                  setState(() {
                    selectedTag = tag;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Tambah', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _saveEntry() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan konten tidak boleh kosong')),
      );
      return;
    }

    final moodData = moods.firstWhere((m) => m['name'] == selectedMood);
    
    final newEntry = JournalEntry(
      id: widget.existingEntry?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      content: _contentController.text,
      date: widget.existingEntry?.date ?? DateTime.now(),
      category: selectedTag,
      emoji: moodData['emoji']!,
      iconType: moodData['color']!,
      imageBytes: _imageBytes,
    );

    if (widget.existingEntry != null) {
      Provider.of<JournalProvider>(context, listen: false).updateEntry(newEntry);
    } else {
      Provider.of<JournalProvider>(context, listen: false).addEntry(newEntry);
    }
    
    Navigator.pop(context);
  }

  Color _getMoodColor(String type) {
    switch (type) {
      case 'leaf': return AppTheme.leafBg;
      case 'bulb': return AppTheme.bulbBg;
      case 'wave': return AppTheme.waveBg;
      case 'lightning': return AppTheme.lightningBg;
      case 'moon': return AppTheme.moonBg;
      default: return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Journal',
          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: _saveEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()).toUpperCase(),
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1),
            ),
            const SizedBox(height: 8),
            Text(
              widget.existingEntry != null ? 'Edit Entri' : 'Entri Baru',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Pilih Mood',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Theme.of(context).textTheme.displayLarge?.color),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  final mood = moods[index];
                  final isSelected = selectedMood == mood['name'];
                  return GestureDetector(
                    onTap: () => setState(() => selectedMood = mood['name']!),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _getMoodColor(mood['color']!),
                              shape: BoxShape.circle,
                              border: isSelected 
                                ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                                : null,
                            ),
                            child: Center(child: Text(mood['emoji']!, style: const TextStyle(fontSize: 24))),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            mood['name']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyLarge?.color,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Judul',
                hintStyle: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5)),
                border: InputBorder.none,
                fillColor: Colors.transparent,
              ),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.displayLarge?.color),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...tags.map((tag) {
                  final isSelected = selectedTag == tag;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTag = tag;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.leafBg : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('# ', style: TextStyle(color: isSelected ? AppTheme.primaryColor : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.black54))),
                          Text(tag, style: TextStyle(color: isSelected ? AppTheme.primaryColor : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.black54), fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                        ],
                      ),
                    ),
                  );
                }),
                GestureDetector(
                  onTap: _showAddTagDialog,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 16, color: Colors.black54),
                        SizedBox(width: 4),
                        Text('Tambah Tag', style: TextStyle(color: Colors.black54, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _contentController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'Ceritakan harimu...',
                      hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5)),
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                    ),
                    style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _saveEntry,
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text('Simpan Entri', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: _buildIconButton(context, Icons.image_outlined),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.waveBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.blue[700]),
                      const SizedBox(width: 12),
                      Text(
                        'Ide Refleksi',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apa satu hal kecil yang membuatmu tersenyum hari ini?',
                    style: TextStyle(color: Colors.blue[900]?.withOpacity(0.8), fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (_imageBytes != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  _imageBytes!,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Theme.of(context).textTheme.bodyMedium?.color),
    );
  }
}

