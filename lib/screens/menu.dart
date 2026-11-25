import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/item_card.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),

      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: burgundy,
      ),

      drawer: const LeftDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

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

                  GridView.count(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    crossAxisCount: 2,
                    childAspectRatio: 2.2,
                    shrinkWrap: true,
                    children: items.take(4).map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),

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
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
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
