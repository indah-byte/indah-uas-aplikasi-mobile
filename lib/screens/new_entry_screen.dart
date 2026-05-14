import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:intl/intl.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  String selectedMood = 'Tenang';
  final List<String> tags = ['syukur', 'pertumbuhan'];

  final List<Map<String, String>> moods = [
    {'name': 'Tenang', 'emoji': '🌿', 'color': 'leaf'},
    {'name': 'Senang', 'emoji': '✨', 'color': 'bulb'},
    {'name': 'Melankolis', 'emoji': '🌊', 'color': 'wave'},
    {'name': 'Energi', 'emoji': '⚡', 'color': 'bulb'},
    {'name': 'Biasa', 'emoji': '☁️', 'color': 'moon'},
  ];

  Color _getMoodColor(String type) {
    switch (type) {
      case 'leaf': return AppTheme.leafBg;
      case 'bulb': return AppTheme.bulbBg;
      case 'wave': return AppTheme.waveBg;
      case 'moon': return AppTheme.moonBg;
      default: return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Journal',
          style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()).toUpperCase(),
              style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Entri Baru',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pilih Mood',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                                ? Border.all(color: AppTheme.primaryColor, width: 2)
                                : null,
                            ),
                            child: Center(child: Text(mood['emoji']!, style: const TextStyle(fontSize: 24))),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            mood['name']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? AppTheme.primaryColor : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
            const TextField(
              decoration: InputDecoration(
                hintText: 'Judul',
                hintStyle: TextStyle(fontSize: 24, color: Colors.grey, fontWeight: FontWeight.w300),
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ...tags.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('# ', style: TextStyle(color: Colors.grey)),
                      Text(tag, style: const TextStyle(color: AppTheme.primaryColor)),
                    ],
                  ),
                )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('Tambah Tag', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Ceritakan harimu...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text('Simpan Entri', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildIconButton(Icons.image_outlined),
                const SizedBox(width: 12),
                _buildIconButton(Icons.mic_none_outlined),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE9F4FB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: AppTheme.primaryColor),
                      SizedBox(width: 12),
                      Text(
                        'Ide Refleksi',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apa satu hal kecil yang membuatmu tersenyum hari ini?',
                    style: TextStyle(color: Colors.blueGrey[700], fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1517842645767-c639042777db?auto=format&fit=crop&q=80&w=1000',
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black54),
    );
  }
}
