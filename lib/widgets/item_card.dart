import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';

// Palet warna MyPortfolio.
const Color burgundy = Color(0xFF500B1B);
const Color cherryBlossom = Color(0xFFDDB5B5);
const Color moss = Color(0xFF5B5429);
const Color skyBlue = Color(0xFFB9C9CC);
const Color sand = Color(0xFFEAE1D7);

// Model untuk setiap item pada homepage.
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

// Widget card yang digunakan pada homepage.
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    // Menentukan warna ikon dan teks agar kontras dengan background.
    final Color foregroundColor =
        item.color == moss || item.color == burgundy
            ? Colors.white
            : burgundy;

    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),

        // Aksi ketika card ditekan.
        onTap: () {
          // Menampilkan SnackBar.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  "Kamu telah menekan tombol ${item.name}!",
                ),
              ),
            );

          // Navigasi ke halaman yang sesuai.
          if (item.name == "Add Experience") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExperienceFormPage(),
              ),
            );
          } else if (item.name == "Add Education") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EducationFormPage(),
              ),
            );
          }
        },

        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: foregroundColor,
                  size: 26.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(3),
                ),
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