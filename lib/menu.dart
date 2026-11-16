import 'package:flutter/material.dart';

// Palet warna MyPortfolio.
const Color burgundy = Color(0xFF500B1B);
const Color cherryBlossom = Color(0xFFDDB5B5);
const Color moss = Color(0xFF5B5429);
const Color skyBlue = Color(0xFFB9C9CC);
const Color sand = Color(0xFFEAE1D7);

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506609132";
  final String nama = "Aisyah Zayyana Hanifah";
  final String kelas = "PBP F";

  final List<ItemHomepage> items = [
    ItemHomepage("Education", Icons.school, burgundy),
    ItemHomepage("Experience", Icons.work, moss),
    ItemHomepage("Add Education", Icons.add_circle, sand),
    ItemHomepage("Add Experience", Icons.add_circle, skyBlue),
    ItemHomepage("Logout", Icons.logout, cherryBlossom),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur visual dasar halaman (AppBar, Body, SnackBar).
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),
      // AppBar menampilkan bar bagian atas halaman aplikasi.
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: burgundy,
      ),
      // Body halaman utama dengan padding di sekelilingnya.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris horizontal untuk menampilkan 3 InfoCard secara sejajar.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            // Bagian tengah: pesan sambutan dan kisi tombol menu portofolio.
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // GridView menampilkan kartu tombol dalam tata letak kisi 2 kolom.
                  GridView.count(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    crossAxisCount: 2,
                    childAspectRatio: 2.2,
                    // shrinkWrap agar ukuran kisi menyesuaikan tinggi konten anak.
                    shrinkWrap: true,
                    children: items.take(4).map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),

                  // Tombol Logout ditampilkan memanjang di tengah bawah.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: ItemCard(items[4]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  // Kartu informasi yang menampilkan judul (title) dan isi (content).
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Memberikan efek bayangan kartu elevasi 2 unit.
      color: Colors.white,
      elevation: 2.0,
      child: Container(
        height: 100,
        // Menyesuaikan lebar kartu dengan proporsi layar (dibagi 3.5).
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        // Menyusun teks title dan content secara vertikal.
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    // Menentukan warna ikon dan teks agar kontras dengan background.
    final Color foregroundColor = item.color == moss || item.color == burgundy
        ? Colors.white
        : burgundy;

    return Material(
      // Menggunakan warna yang sudah ditentukan untuk setiap tombol.
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () {
          // Menampilkan SnackBar dengan pesan interaktif.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: foregroundColor, size: 26.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}