import 'dart:typed_data';

class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String category;
  final String emoji;
  final String iconType; // e.g., 'leaf', 'bulb', 'moon', 'wave'
  final Uint8List? imageBytes;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
    required this.emoji,
    required this.iconType,
    this.imageBytes,
  });
}
