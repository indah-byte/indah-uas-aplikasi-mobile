import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../theme/app_theme.dart';
import 'package:intl/intl.dart';

import 'journal_detail_screen.dart';
import 'new_entry_screen.dart';
import 'profile_screen.dart';
import '../widgets/app_drawer.dart';

class JournalListScreen extends StatelessWidget {
  final List<JournalEntry> entries = [
    JournalEntry(
      id: '1',
      title: 'Pagi yang Menenanglan',
      content: 'Hari ini dimulai dengan secangkir teh di teras. Menghirup udara...',
      date: DateTime(2026, 10, 12, 8, 30),
      category: 'syukur',
      emoji: '🌿',
      iconType: 'leaf',
    ),
    JournalEntry(
      id: '2',
      title: 'Refleksi Proyek Besar',
      content: 'Akhirnya menyelesaikan milestone pertama. Ternyata...',
      date: DateTime(2026, 10, 11, 21, 15),
      category: 'kerja',
      emoji: '💡',
      iconType: 'bulb',
    ),
    JournalEntry(
      id: '3',
      title: 'Melepaskan Lelah',
      content: 'Malam ini terasa sunyi. Terkadang',
      date: DateTime(2026, 10, 10, 23, 45),
      category: 'istirahat',
      emoji: '🌙',
      iconType: 'moon',
    ),
    JournalEntry(
      id: '4',
      title: 'Suara Ombak',
      content: 'Berjalan di tepi pantai memberikan perspektif baru....',
      date: DateTime(2026, 10, 9, 17, 0),
      category: 'santai',
      emoji: '🌊',
      iconType: 'wave',
    ),
  ];

  JournalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppTheme.primaryColor),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Sanctuary',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Text('img', style: TextStyle(fontSize: 12, color: Colors.black54)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Jurnal Saya',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Tuangkan pikiranmu hari ini.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 40),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  return TimelineItem(
                    entry: entries[index],
                    isLast: index == entries.length - 1,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewEntryScreen()),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final JournalEntry entry;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.entry,
    required this.isLast,
  });

  Color _getIconBgColor() {
    switch (entry.iconType) {
      case 'leaf': return AppTheme.leafBg;
      case 'bulb': return AppTheme.bulbBg;
      case 'moon': return AppTheme.moonBg;
      case 'wave': return AppTheme.waveBg;
      default: return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getIconBgColor(),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    entry.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.blue.withOpacity(0.1),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JournalDetailScreen(entry: entry),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd Okt, HH:mm').format(entry.date),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getIconBgColor().withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '#${entry.category}',
                              style: TextStyle(
                                color: Color.lerp(_getIconBgColor(), Colors.black, 0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        entry.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isLast) const SizedBox(height: 80), // Space for FAB
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}
