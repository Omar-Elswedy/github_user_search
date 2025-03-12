import 'package:flutter/material.dart';
import 'package:github_user_search/providers/user_provider.dart';
import 'package:github_user_search/repositories/user_repository_impl.dart';
import 'package:github_user_search/services/local/shared_prefs_service.dart';
import 'package:github_user_search/services/remote/api_service.dart';
import 'package:github_user_search/views/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsService().init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(
        userRepository: UserRepositoryImpl(
          apiService: ApiService(),
        ),
      ),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchScreen(),
    );
  }
}
