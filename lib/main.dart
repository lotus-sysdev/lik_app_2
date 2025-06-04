import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lik_app_2/core/theme/app_theme.dart';
import 'package:lik_app_2/core/utils/secure_storage.dart';
import 'package:lik_app_2/presentation/pages/login_page.dart';
import 'package:lik_app_2/presentation/pages/main_menu_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'LIK App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      home: FutureBuilder<bool>(
        future: SecureStorage().hasToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data == true
              ? const MainMenuPage()
              : const LoginPage();
        },
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/main_menu': (context) => const MainMenuPage(),
      },
    );
  }
}
