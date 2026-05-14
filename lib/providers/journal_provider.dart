import 'package:flutter/material.dart';
import '../models/journal_entry.dart';

class JournalProvider with ChangeNotifier {
  final List<JournalEntry> _entries = [
    JournalEntry(
      id: '1',
      title: 'Pagi yang Menenangkan',
      content: 'Hari ini dimulai dengan secangkir teh di teras. Menghirup udara pagi yang segar benar-benar memberikan energi baru.',
      date: DateTime(2026, 10, 12, 8, 30),
      category: 'syukur',
      emoji: '🌿',
      iconType: 'leaf',
    ),
    JournalEntry(
      id: '2',
      title: 'Refleksi Proyek Besar',
      content: 'Akhirnya menyelesaikan milestone pertama. Ternyata tantangan terbesarnya bukan pada teknis, tapi komunikasi.',
      date: DateTime(2026, 10, 11, 21, 15),
      category: 'kerja',
      emoji: '💡',
      iconType: 'bulb',
    ),
  ];

  List<JournalEntry> get entries => [..._entries];

  void addEntry(JournalEntry entry) {
    _entries.insert(0, entry);
    notifyListeners();
  }

  void deleteEntry(String id) {
    _entries.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
