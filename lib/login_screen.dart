import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'main_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const LoginScreen({super.key, required this.onToggleTheme});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late bool _isWhiteBackground;

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    _isWhiteBackground = box.read('isWhiteBackground') ?? false;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _processLogin() {
    final emailOrId = _emailController.text.trim();
    final password = _passwordController.text;

    if (emailOrId.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email/ID dan password tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final box = GetStorage();
    final registeredEmail = box.read('userEmail');
    final registeredUserId = box.read('userId');
    final registeredPassword = box.read('password');

    final isValidUser =
        (emailOrId == registeredEmail || emailOrId == registeredUserId);
    final isValidPassword = password == registeredPassword;

    if (!isValidUser || !isValidPassword) {
      Get.snackbar(
        'Login Gagal',
        'Email/ID atau password salah atau belum terdaftar',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Simpan sesi login
    box.write('username', registeredUserId);
    box.write('loggedInEmail', registeredEmail);

    Get.offAll(
      () => MainScreen(
        username: registeredUserId,
        onToggleTheme: widget.onToggleTheme,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    _isWhiteBackground = box.read('isWhiteBackground') ?? false;
    bool isDarkMode = box.read('isDarkMode') ?? true;

    return Scaffold(
      backgroundColor:
          _isWhiteBackground
              ? Colors.white
              : (isDarkMode ? Colors.black : Colors.white),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 20),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 1),
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/udb.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.blue,
                                child: Icon(
                                  Icons.wifi,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                  "Internet dan Cafe Terbaik SeSolo Raya",
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        _isWhiteBackground
                            ? Colors.grey[700]
                            : (isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color:
                        _isWhiteBackground
                            ? Colors.black
                            : (isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  style: TextStyle(
                    color:
                        _isWhiteBackground
                            ? Colors.black
                            : (isDarkMode ? Colors.white : Colors.black),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email atau ID Pengguna',
                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                    filled: true,
                    fillColor:
                        _isWhiteBackground
                            ? Colors.grey.shade100
                            : (isDarkMode
                                ? Colors.grey.shade900
                                : Colors.grey.shade100),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(
                    color:
                        _isWhiteBackground
                            ? Colors.black
                            : (isDarkMode ? Colors.white : Colors.black),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    filled: true,
                    fillColor:
                        _isWhiteBackground
                            ? Colors.grey.shade100
                            : (isDarkMode
                                ? Colors.grey.shade900
                                : Colors.grey.shade100),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _processLogin,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text("Masuk", style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    Get.to(
                      () => RegisterScreen(onToggleTheme: widget.onToggleTheme),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Daftar",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
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
