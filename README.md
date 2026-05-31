## Daily Journal
## 1. Arsitektur Folder (Struktur Project)
Jika Anda menggunakan Flutter, gunakan struktur yang rapi agar mudah dikelola:
    - lib/models/: Untuk definisi data (misal: entry_model.dart).
    - lib/screens/: Folder berisi halaman (Home, Edit Catatan, Detail).
    - lib/services/: Folder untuk database (SQLite atau Local Storage).
    - lib/widgets/: Komponen kecil yang dipakai berulang (Card catatan, Tombol Mood).

## 2. Skema Data (Model Catatan)
Data adalah inti dari jurnal. Berikut adalah atribut yang perlu Anda simpan dalam satu objek catatan:
    - id: (Int/String) Identitas unik setiap catatan.
    - title: (String) Judul jurnal.
    - content: (Text) Isi cerita.
    - mood: (String) Nama emoji atau kode perasaan (misal: "happy", "sad").
    -date: (DateTime) Tanggal pembuatan.
    - imagePath: (String, Optional) Lokasi file foto jika ada.

## 3. Alur Pengguna (User Journey)
- Halaman Utama (Timeline): Pengguna melihat daftar catatan dalam bentuk Card. Ada tombol "+" besar untuk menambah catatan baru.
- Halaman Input: Pengguna memilih Mood, menulis Judul, dan mengetik isi jurnal.
- Proses Simpan: Data dikirim ke database lokal.
- Halaman Detail: Saat salah satu daftar di klik, muncul isi lengkap jurnal untuk dibaca atau diedit.

## 4. Komponen UI Penting
- List View: Untuk menampilkan daftar catatan secara vertikal.
- Floating Action Button (FAB): Tombol bulat di pojok bawah untuk membuat catatan baru.
- Bottom Sheet / Modal: Bisa digunakan untuk memilih Mood (Emoji Picker).
- TextFormField: Untuk area mengetik jurnal dengan fitur auto-expand.

## 5. Rekomendasi Stack Teknologi (Local First)
Untuk aplikasi yang mudah dan cepat, gunakan kombinasi ini:
- UI: Flutter (karena Anda sedang mendalaminya).
- Database: sqflite (Database SQL lokal) atau Hive (Database NoSQL yang sangat cepat untuk Flutter).
- Penyimpanan Gambar: image_picker (plugin untuk mengambil foto dari galeri/kamera).

## 6. Roadmap Pengembangan (Tahapan Kerja)
- Hari 1-2: Buat UI sederhana (Halaman Daftar & Halaman Input).
- Hari 3-4: Implementasikan Model Data dan Database Lokal (Simpan & Baca).
- Hari 5: Tambahkan fitur Mood Tracker sederhana (pilih emoji).
- Hari 6: Percantik tampilan (Warna, Font, dan Mode Gelap).
- Hari 7: Testing dan perbaikan bug.

## Contoh Struktur Data (Pseudo-code)
Jika Anda mulai menulis kodenya di Flutter, kira-kira bentuk datanya akan seperti ini:

Dart
class JournalEntry {
  final int? id;
  final String title;
  final String content;
  final String mood;
  final DateTime date;

  JournalEntry({this.id, required this.title, required this.content, required this.mood, required this.date});

  // Fungsi untuk mengubah data ke Map (untuk disimpan ke Database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'mood': mood,
      'date': date.toIso8601String(),
    };
  }
}