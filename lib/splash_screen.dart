import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const SplashScreen({super.key, required this.onToggleTheme});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    Future.delayed(Duration(seconds: 3), () {
      final box = GetStorage();
      String? username = box.read('username');
      String? password = box.read('password');

      if (username != null &&
          password != null &&
          username.isNotEmpty &&
          password.isNotEmpty) {
        Get.off(
          () => MainScreen(
            username: username,
            onToggleTheme: widget.onToggleTheme,
          ),
        );
      } else {
        Get.off(() => LoginScreen(onToggleTheme: widget.onToggleTheme));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/images/udb.png', // Ganti dengan logo Anda
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.wifi_tethering,
                    size: 100,
                    color: Colors.blue,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "CAFE & WARNET SOLUTION",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Internet dan Cafe Terbaik SeSolo Raya", // Tambahkan tulisan ini
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 20),
            RotationTransition(
              turns: _animation,
              child: Container(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  strokeWidth: 4,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
