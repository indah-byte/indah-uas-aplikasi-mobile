import 'package:flutter/material.dart';
import '../models/journal_entry.dart';

class JournalProvider with ChangeNotifier {
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  final List<JournalEntry> _entries = [
    JournalEntry(
      id: '1',
      title: 'Pagi yang Tenang',
      content: 'Hari ini dimulai dengan secangkir kopi hangat dan udara segar. Rasanya damai sekali melihat matahari terbit.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'syukur',
      emoji: '🌿',
      iconType: 'leaf',
    ),
    JournalEntry(
      id: '2',
      title: 'Ide Cemerlang',
      content: 'Mendapat inspirasi baru untuk proyek tulisan berikutnya. Kadang ide terbaik datang saat kita paling rileks.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: 'kerja',
      emoji: '✨',
      iconType: 'bulb',
    ),
  ];

  List<JournalEntry> get entries => [..._entries];

  void addEntry(JournalEntry entry) {
    _entries.insert(0, entry);
    notifyListeners();
  }

  void updateEntry(JournalEntry updatedEntry) {
    final index = _entries.indexWhere((e) => e.id == updatedEntry.id);
    if (index != -1) {
      _entries[index] = updatedEntry;
      notifyListeners();
    }
  }

  void deleteEntry(String id) {
    _entries.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

