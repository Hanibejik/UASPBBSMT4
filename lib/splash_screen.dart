import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  // Remove isLogout parameter since we'll handle logout differently
  final int splashDuration;

  const SplashScreen({
    super.key,
    required this.onToggleTheme,
    this.splashDuration = 3,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Check credentials and navigate to appropriate screen
    Future.delayed(Duration(seconds: widget.splashDuration), () {
      _checkCredentialsAndNavigate();
    });
  }

  void _checkCredentialsAndNavigate() {
    final box = GetStorage();
    String? username = box.read('username');
    String? password = box.read('password');

    if (username != null &&
        password != null &&
        username.isNotEmpty &&
        password.isNotEmpty) {
      Get.offAll(
        () =>
            MainScreen(username: username, onToggleTheme: widget.onToggleTheme),
      );
    } else {
      Get.offAll(() => LoginScreen(onToggleTheme: widget.onToggleTheme));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme from storage
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? true;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with animation
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.6, end: 1.0),
                duration: Duration(seconds: 1),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 25,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/udb.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade300,
                                  Colors.blue.shade700,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Icon(
                              Icons.wifi_tethering,
                              size: 100,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Colors.blue.shade300, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Text(
                  "CAFE & WARNET SOLUTION",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Internet dan Cafe Terbaik SeSolo Raya",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                ),
              ),
              SizedBox(height: 40),
              RotationTransition(
                turns: _animation,
                child: Container(
                  width: 45,
                  height: 45,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade300, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 4,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
