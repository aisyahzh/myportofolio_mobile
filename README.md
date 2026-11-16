# MyPortfolio Mobile

**Nama:** Aisyah Zayyana Hanifah

**NPM:** 2506609132

**Kelas:** PBP F

## Deskripsi

MyPortfolio Mobile merupakan aplikasi portofolio pribadi berbasis mobile yang dikembangkan menggunakan Flutter dan Dart sebagai pengembangan dari website portofolio yang telah dibuat pada proyek PBP sebelumnya.

## Features

- Personal information yang menampilkan NPM, nama lengkap, dan kelas.
- Education section.
- Experience section.
- Add Education.
- Add Experience.
- Logout.
- Interactive menu menggunakan ItemCard.
- SnackBar notification ketika tombol ditekan.
- Custom background color untuk setiap tombol menu.
- Responsive scrolling layout.

## Tech Stack

- Flutter
- Dart
- Material Design
- Git & GitHub

## Project Structure

```text
myportofolio_mobile/
├── android/                  # Proyek pembungkus native Android
├── ios/                      # Proyek pembungkus native iOS
├── lib/                      # Sumber kode utama Dart
│   ├── main.dart             # Entry point aplikasi
│   └── menu.dart             # Widget halaman utama dan komponen menu
├── linux/                    # Proyek pembungkus native Linux
├── macos/                    # Proyek pembungkus native macOS
├── web/                      # Konfigurasi aplikasi Flutter Web
├── windows/                  # Proyek pembungkus native Windows
├── test/                     # Berkas pengujian
├── analysis_options.yaml      # Konfigurasi Dart analyzer
├── pubspec.yaml              # Konfigurasi dan dependensi proyek
├── pubspec.lock              # Versi dependensi yang digunakan
└── README.md                 # Dokumentasi proyek
```

## Local Setup

### 1. Clone Repository

```bash
git clone <repository-url>
cd myportofolio_mobile
```

### 2. Pastikan Flutter SDK Terpasang

Periksa instalasi Flutter dengan menjalankan:

```bash
flutter --version
```

Untuk memeriksa konfigurasi lingkungan pengembangan:

```bash
flutter doctor
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Jalankan Aplikasi

Pastikan emulator Android atau perangkat fisik sudah terhubung, kemudian jalankan:

```bash
flutter devices
```

Jalankan aplikasi dengan perintah:

```bash
flutter run
```

### 5. Analyze Project

Untuk memeriksa apakah terdapat masalah pada kode:

```bash
flutter analyze
```

## Development Progress

### Tutorial 08

- Melakukan setup Flutter SDK dan IDE.
- Membuat proyek Flutter bernama `myportofolio_mobile`.
- Memahami struktur dasar proyek Flutter.
- Memisahkan kode halaman utama ke dalam file `menu.dart`.
- Mengubah `MyHomePage` menjadi `StatelessWidget`.
- Membuat widget `InfoCard` untuk menampilkan informasi pemilik portofolio.
- Membuat widget `ItemCard` untuk menampilkan menu aksi portofolio.

### Tugas 7

- Melanjutkan pengembangan proyek Flutter dari Tutorial 08.
- Mengganti informasi contoh dengan identitas pribadi.
- Menambahkan informasi NPM, Name, dan Class menggunakan `InfoCard`.
- Menambahkan lima menu aksi, yaitu Education, Experience, Add Education, Add Experience, dan Logout.
- Menambahkan ikon yang sesuai dengan setiap menu.
- Mengimplementasikan atribut `Color` pada model `ItemHomepage` agar setiap kartu memiliki warna latar yang berbeda.
- Menyesuaikan kombinasi warna menggunakan burgundy, cherry blossom, moss, sky blue, dan sand.
- Mengatur tata letak menu menggunakan `GridView.count` dengan dua kolom.
- Menempatkan tombol Logout secara terpisah di bagian bawah halaman.
- Menambahkan `SnackBar` untuk memberikan notifikasi ketika tombol ditekan.
- Menambahkan scrolling agar seluruh konten dapat diakses pada layar dengan ukuran berbeda.
- Melakukan pengujian tampilan dan interaksi aplikasi.

## Refleksi

### Tugas 7

**1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

Widget tree adalah struktur hierarki yang menggambarkan hubungan antar-widget dalam aplikasi Flutter. Setiap widget dapat memiliki widget lain sebagai anaknya sehingga membentuk sebuah struktur seperti pohon.

Widget yang berada di bagian atas disebut parent, sedangkan widget yang berada di dalamnya disebut child. Parent menentukan bagaimana child disusun atau ditampilkan.

Pada proyek MyPortfolio Mobile, contohnya adalah `MaterialApp` yang menjadi root widget dan memiliki `MyHomePage` sebagai halaman utama. Di dalam `MyHomePage`, terdapat `Scaffold` yang memiliki `AppBar` dan `body`. Selanjutnya, bagian body berisi widget seperti `Padding`, `Column`, `Row`, `InfoCard`, dan `GridView`.

Hubungan parent-child ini membuat tampilan aplikasi dapat disusun menjadi bagian-bagian kecil yang lebih terstruktur. Dengan menggunakan widget tree, saya juga bisa memisahkan komponen tertentu menjadi widget tersendiri agar lebih mudah digunakan kembali dan dikelola.

**2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**

Pada proyek MyPortfolio Mobile, saya menggunakan beberapa widget Flutter untuk menyusun tampilan dan interaksi aplikasi, yaitu:

- `MaterialApp`: Menjadi pembungkus utama aplikasi dan menyediakan konfigurasi tema serta halaman awal.
- `Scaffold`: Menyediakan struktur dasar halaman aplikasi, seperti AppBar dan body.
- `AppBar`: Menampilkan bagian header aplikasi dengan judul MyPortfolio.
- `StatelessWidget`: Digunakan sebagai superclass untuk widget yang tidak membutuhkan perubahan state internal, seperti MyHomePage, InfoCard, dan ItemCard.
- `Padding`: Memberikan jarak antara konten dengan batas area di sekitarnya.
- `SingleChildScrollView`: Memungkinkan halaman digulir ketika kontennya melebihi ukuran layar.
- `Column`: Menyusun widget secara vertikal.
- `Row`: Menyusun widget secara horizontal.
- `Center`: Menempatkan child di bagian tengah area yang tersedia.
- `Card`: Menampilkan informasi profil dalam bentuk kartu.
- `Container`: Mengatur ukuran, padding, dan tata letak konten.
- `SizedBox`: Memberikan jarak atau menentukan ukuran widget.
- `Text`: Menampilkan teks seperti identitas pemilik dan nama menu.
- `Icon`: Menampilkan ikon yang mewakili setiap menu.
- `GridView.count`: Menampilkan kumpulan menu dalam bentuk grid dengan jumlah kolom yang ditentukan.
- `Material`: Menjadi dasar tampilan kartu menu dan mengatur warna latar serta bentuk sudutnya.
- `InkWell`: Memberikan respons interaksi ketika kartu ditekan.
- `SnackBar`: Menampilkan pesan singkat sebagai feedback kepada pengguna.
- `ScaffoldMessenger`: Mengelola dan menampilkan SnackBar pada halaman.
- `MediaQuery`: Mengakses informasi ukuran layar untuk menyesuaikan ukuran komponen.
- `ThemeData`: Mengatur tema visual aplikasi.
- `ColorScheme`: Menyediakan skema warna yang digunakan dalam tema aplikasi.

Selain widget bawaan Flutter tersebut, saya juga membuat beberapa komponen sendiri, yaitu:

- `MyHomePage`: Widget halaman utama yang menampilkan informasi profil dan menu portofolio.
- `InfoCard`: Widget untuk menampilkan informasi NPM, nama, dan kelas dalam bentuk kartu.
- `ItemCard`: Widget untuk menampilkan tombol menu beserta ikon, warna, dan interaksi SnackBar.

Saya juga membuat class `ItemHomepage` sebagai model untuk menyimpan informasi setiap menu, seperti nama, ikon, dan warna kartu. Class ini bukan widget, tetapi membantu mengatur data menu agar lebih terstruktur.

**3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

`MaterialApp` merupakan widget yang menyediakan konfigurasi dasar untuk aplikasi Flutter yang menggunakan Material Design. Widget ini mengatur beberapa hal seperti tema aplikasi, navigasi, dan halaman awal yang akan ditampilkan.

Pada proyek saya, `MaterialApp` digunakan sebagai root widget di dalam fungsi `main()` melalui pemanggilan `runApp(const MyApp())`. Di dalam `MaterialApp`, saya mengatur judul aplikasi, tema menggunakan `ThemeData`, serta halaman awal menggunakan `MyHomePage`.

`MaterialApp` umumnya digunakan sebagai root widget karena menyediakan berbagai fitur dasar yang dibutuhkan aplikasi sehingga widget-widget di bawahnya dapat menggunakan konfigurasi tersebut secara konsisten. Dengan begitu, pengaturan tema dan navigasi aplikasi menjadi lebih mudah dikelola.

**4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

`StatelessWidget` adalah widget yang tidak memiliki state internal yang dapat berubah selama widget tersebut digunakan. Tampilan yang dihasilkan bergantung pada nilai atau data yang diberikan ketika widget dibuat. Sementara itu, `StatefulWidget` adalah widget yang memiliki state yang dapat berubah selama aplikasi berjalan. Perubahan state tersebut dapat menyebabkan widget dibangun ulang menggunakan `setState()`.

Pada proyek MyPortfolio Mobile, saya menggunakan `StatelessWidget` pada `MyHomePage`, `InfoCard`, dan `ItemCard`. Hal ini karena ketiga widget tersebut hanya menampilkan informasi dan komponen menu berdasarkan data yang sudah diberikan. Menurut saya, `StatelessWidget` lebih cocok digunakan ketika tampilan tidak perlu mengelola perubahan data secara internal. Sebaliknya, `StatefulWidget` lebih tepat digunakan ketika terdapat interaksi yang menyebabkan perubahan tampilan, misalnya form dengan input pengguna, tombol untuk mengubah status, atau fitur yang memerlukan pembaruan data secara langsung.

Dengan memilih jenis widget yang sesuai, kode aplikasi dapat menjadi lebih sederhana dan mudah dipahami.

**5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

`BuildContext` adalah objek yang merepresentasikan posisi sebuah widget di dalam widget tree. Melalui `BuildContext`, sebuah widget dapat mengakses informasi dan fitur yang disediakan oleh widget-widget di atasnya. `BuildContext` penting karena Flutter menggunakannya untuk mengetahui posisi widget sehingga widget tersebut dapat mengakses konfigurasi seperti tema, ukuran layar, dan layanan lain yang tersedia pada widget tree.

Pada proyek saya, `BuildContext` digunakan di dalam metode `build()` pada beberapa widget. Contohnya, saya menggunakan `Theme.of(context).colorScheme.primary` untuk mengambil warna utama dari tema aplikasi. Selain itu, saya juga menggunakan `MediaQuery.of(context).size.width` untuk mendapatkan lebar layar sehingga ukuran kartu informasi dapat disesuaikan dengan ukuran perangkat. Saya juga menggunakan `ScaffoldMessenger.of(context)` di dalam fungsi `onTap` pada `ItemCard` untuk menampilkan SnackBar ketika pengguna menekan tombol menu.

Jadi, `BuildContext` membantu widget berinteraksi dengan lingkungan tempat widget tersebut berada di dalam widget tree.

**6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

Hot reload merupakan fitur Flutter yang memungkinkan developer melihat perubahan kode secara langsung tanpa harus menjalankan ulang seluruh aplikasi. Fitur ini mempertahankan state aplikasi yang sedang berjalan sehingga proses pengembangan menjadi lebih cepat.

Hot restart berbeda dengan hot reload karena hot restart akan memulai ulang aplikasi dari awal. Akibatnya, state aplikasi yang sedang berjalan akan di-reset, tetapi developer tidak perlu membangun ulang aplikasi sepenuhnya seperti pada full restart.

Pada saat mengembangkan MyPortfolio Mobile, saya menggunakan hot reload untuk melihat perubahan tampilan setelah mengatur warna kartu, ukuran tombol, dan tata letak menu. Dengan begitu, saya dapat langsung melihat hasil perubahan tanpa harus menjalankan ulang aplikasi dari awal.

Hot reload biasanya cukup digunakan ketika melakukan perubahan pada tampilan atau isi widget. Namun, hot restart diperlukan ketika perubahan berkaitan dengan inisialisasi aplikasi atau state awal yang tidak diperbarui melalui hot reload.

Sementara itu, full restart diperlukan ketika perubahan melibatkan konfigurasi native atau perubahan lain yang membutuhkan proses build ulang aplikasi, misalnya perubahan konfigurasi Android atau iOS dan penambahan plugin native tertentu.

Dengan adanya fitur hot reload dan hot restart, proses pengembangan aplikasi Flutter menjadi lebih efisien karena saya tidak perlu selalu menjalankan ulang aplikasi secara keseluruhan setiap kali melakukan perubahan.

## AI Disclosure

Saya menggunakan ChatGPT sebagai alat bantu selama proses pengerjaan Tutorial 08 dan Tugas 7. AI digunakan untuk membantu memahami konsep dasar Flutter seperti widget tree, StatelessWidget, MaterialApp, dan BuildContext. 

Saya tidak langsung menggunakan semua saran yang diberikan. Saya mencoba menjalankan aplikasi, melihat hasilnya, dan melakukan penyesuaian kembali apabila hasilnya belum sesuai dengan yang diinginkan. Misalnya, saya melakukan beberapa penyesuaian pada ukuran kartu, jumlah kolom GridView, serta posisi tombol Logout sampai mendapatkan tampilan yang lebih sesuai.