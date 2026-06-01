# Sanctuary 🌿

**Sanctuary** adalah aplikasi jurnal minimalis dan eksklusif yang dirancang untuk menjadi ruang privat Anda dalam menuangkan pikiran, melacak *mood*, dan menemukan ketenangan (*finding stillness through words*). Aplikasi ini merupakan hasil transformasi komprehensif ke antarmuka kelas atas (*Premium Tier*) dengan fokus pada *mindfulness* dan keindahan tipografi.

## 1. Konsep Utama & Branding
- **Nama Aplikasi:** Sanctuary (Premium Edition)
- **Tema Visual:** *Deep Emerald* dipadukan dengan *Champagne Gold*. Desain UI mengedepankan gaya elegan, ruang kosong (*whitespace*), tipografi mewah (kombinasi Serif dan Sans-Serif), serta animasi *staggered* yang sangat mulus.
- **Fungsi Utama:** Jurnal refleksi harian interaktif dengan sistem *tagging*, pelacak *mood* berbasis ikon estetis, dan dukungan galeri gambar.

## 2. Arsitektur Folder (Struktur Project)
Struktur di dalam `lib/` disusun secara modular dan skalabel:
- `lib/models/`: Definisi skema data (misal: `journal_entry.dart`).
- `lib/screens/`: Halaman utama aplikasi (`SplashScreen`, `JournalListScreen`, `NewEntryScreen`, `JournalDetailScreen`).
- `lib/providers/`: Manajemen state menggunakan *Provider* (`journal_provider.dart` mengelola entri dan tema gelap/terang).
- `lib/widgets/`: Komponen UI modular (misal: `AppDrawer` yang menampung pengaturan tema).
- `lib/theme/`: Sistem desain terpusat (`app_theme.dart`) untuk mengatur palet warna dinamis (Terang & Gelap) serta token tipografi premium.

## 3. Skema Data (Model Journal Entry)
Data inti dari aplikasi ini berfokus pada memori dan refleksi:
- `id`: (String) ID unik entri.
- `title`: (String) Judul jurnal atau inti pikiran hari ini.
- `content`: (String) Isi cerita secara mendalam.
- `category`: (String) *Tag* kustom yang bisa dibuat pengguna (cth: #syukur, #kerja).
- `date`: (DateTime) Waktu penulisan jurnal.
- `emoji`: (String) Ikon *mood* (🌿, ✨, 🌊, ⚡, ☁️).
- `iconType`: (String) Pengenal warna latar belakang ikon *mood*.
- `imageBytes`: (Uint8List, Opsional) Foto memori yang diunggah pengguna.

## 4. Alur Pengguna (User Journey)
1. **Splash Screen Sinematik:** Sambutan animasi elegan (efek *fade & scale*) dengan nuansa warna zamrud dan emas.
2. **Timeline Garis Waktu:** Layar utama (`CustomScrollView` & `SliverAppBar`) menampilkan entri secara berjatuhan (*staggered animation*).
3. **Menu Pengaturan:** *Drawer* minimalis dengan fitur *Toggle* Mode Malam (Dark Mode) dan *About App*.
4. **Editor Entri:** Pembuatan dan pengubahan jurnal. Pengguna dapat memilih *mood*, menambahkan *tag* dinamis, mengunggah foto, dan menyimpannya ke *state*.
5. **Detail & Refleksi:** Menampilkan bacaan jurnal secara *full-screen* dengan tipografi ala majalah (Playfair Display) lengkap dengan foto, *tag*, dan stempel waktu. Tersedia fitur pengubahan (Edit) dan penghapusan (Delete).

## 5. Komponen UI & Desain
- **Warna Dinamis (Light/Dark Mode):** 
  - *Light Mode*: Latar *Off-white* premium dengan teks kontras tinggi.
  - *Dark Mode*: Latar OLED-Black berlapis *Gunmetal* gelap (0xFF121212) yang nyaman di mata.
- **Tipografi:** Google Fonts `Playfair Display` untuk judul (memberi kesan klasik nan elegan) dan `Outfit` untuk teks bacaan modern.
- **Glassmorphism & Shadows:** Penggunaan bayangan lembut (opacity rendah) dan sudut kartu yang melengkung (*rounded 24px*) memberi efek *floating*.
- **Animasi:** `TweenAnimationBuilder` memicu pergerakan elemen tanpa jeda patah.

## 6. Stack Teknologi & Package
- **Framework:** Flutter (Disesuaikan khusus untuk kompatibilitas Flutter Web).
- **State Management:** `provider` (Pengelola entri jurnal & perpindahan Tema).
- **Upload Media:** `image_picker` (Menggunakan konversi `Uint8List` yang kompatibel dengan web/desktop/mobile).
- **Format Data:** `intl` (Untuk format tanggal interaktif).
- **Tipografi:** `google_fonts` (Memanggil font premium secara langsung).

## 7. Status Pengembangan (Selesai)
- ✅ Transisi penuh dari tema "Gearhead" ke tema "Sanctuary".
- ✅ Penerapan animasi kelas atas di seluruh navigasi halaman.
- ✅ Implementasi fitur *Image Upload* tanpa error di Flutter Web.
- ✅ Pembuatan *Dynamic Dark/Light Mode* menyeluruh.
- ✅ *CRUD* Penuh (Buat, Baca, Ubah, Hapus) menggunakan arsitektur *Offline-First* di *Provider*.