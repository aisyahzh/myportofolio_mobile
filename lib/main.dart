import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.apiClient, super.key});

  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Menyediakan ApiClient untuk widget yang membutuhkan API.
        Provider.value(value: apiClient),

        // Menyediakan AuthState dan memberi tahu widget
        // ketika status login berubah.
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState(apiClient)),
      ],
      child: MaterialApp(
        title: 'MyPortfolio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            secondary: Colors.amber[700],
          ),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
