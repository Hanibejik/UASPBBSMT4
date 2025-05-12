import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final box = GetStorage();
  bool isLoggedIn = box.read('username') != null;
  bool justLoggedOut = box.read('justLoggedOut') == true;

  runApp(MyApp(showSplash: !isLoggedIn || justLoggedOut));
}

class MyApp extends StatefulWidget {
  final bool showSplash;

  const MyApp({super.key, required this.showSplash});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    _themeMode =
        box.read('isDarkMode') ?? true ? ThemeMode.dark : ThemeMode.light;
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      final box = GetStorage();
      box.write('isDarkMode', _themeMode == ThemeMode.dark);
    });
  }

  Widget _getHomeAfterSplash() {
    final box = GetStorage();
    box.remove('justLoggedOut'); // Reset flag logout

    final username = box.read('username');
    final password = box.read('password');

    if (username != null && password != null) {
      return MainScreen(username: username, onToggleTheme: _toggleTheme);
    } else {
      return LoginScreen(onToggleTheme: _toggleTheme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe & Warnet Solution',
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        cardColor: const Color(0xFF111827),
        useMaterial3: true,
      ),
      home:
          widget.showSplash
              ? SplashScreen(onToggleTheme: _toggleTheme)
              : _getHomeAfterSplash(),
    );
  }
}
