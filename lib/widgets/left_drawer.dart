import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF500B1B)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal experiences and educations!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),

          // Home
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),

          // Add Experience
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Add Experience'),
            onTap: () async {
              final loggedIn = await ensureLoggedIn(context);

              if (!context.mounted || !loggedIn) return;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExperienceFormPage(),
                ),
              );
            },
          ),

          // Add Education
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Add Education'),
            onTap: () async {
              final loggedIn = await ensureLoggedIn(context);

              if (!context.mounted || !loggedIn) return;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EducationFormPage(),
                ),
              );
            },
          ),

          const Divider(),

          // Login atau Logout
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await context.read<AuthState>().logout();

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout successful')),
                );
              },
            ),
        ],
      ),
    );
  }
}
