import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'main_screen.dart';

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
    // Load background preference
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
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan password tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final box = GetStorage();
    box.write('username', _emailController.text);
    box.write('password', _passwordController.text);

    Get.offAll(
      () => MainScreen(
        username: _emailController.text,
        onToggleTheme: widget.onToggleTheme,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Reload background preference in case it changed
    final box = GetStorage();
    _isWhiteBackground = box.read('isWhiteBackground') ?? false;
    bool isDarkMode = box.read('isDarkMode') ?? true;

    return Scaffold(
      backgroundColor:
          _isWhiteBackground
              ? Colors.white
              : (isDarkMode ? Colors.black : Colors.white),
      // Menghilangkan AppBar yang berisi tombol ganti tema
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Menambahkan SafeArea untuk menggantikan AppBar
                SizedBox(height: MediaQuery.of(context).padding.top + 20),

                // Logo with animation
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
                              color:
                                  _isWhiteBackground
                                      ? Colors.blue.withOpacity(0.5)
                                      : (isDarkMode
                                          ? Colors.blue.withOpacity(0.3)
                                          : Colors.blue.withOpacity(0.5)),
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
                                  Icons.wifi_tethering,
                                  size: 60,
                                  color: Colors.white,
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
                SizedBox(height: 8),
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
                SizedBox(height: 50),

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

                // Email field with animation
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-0.2, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(0.2, 0.6, curve: Curves.easeOut),
                    ),
                  ),
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(
                      color:
                          _isWhiteBackground
                              ? Colors.black
                              : (isDarkMode ? Colors.white : Colors.black),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color:
                            _isWhiteBackground
                                ? Colors.grey[700]
                                : (isDarkMode ? Colors.grey : Colors.grey[700]),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color:
                              _isWhiteBackground
                                  ? Colors.grey.shade300
                                  : (isDarkMode
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade300),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                      filled: true,
                      fillColor:
                          _isWhiteBackground
                              ? Colors.grey.shade50
                              : (isDarkMode
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade50),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password field with animation
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.2, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(0.4, 0.8, curve: Curves.easeOut),
                    ),
                  ),
                  child: TextField(
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
                      labelStyle: TextStyle(
                        color:
                            _isWhiteBackground
                                ? Colors.grey[700]
                                : (isDarkMode ? Colors.grey : Colors.grey[700]),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color:
                              _isWhiteBackground
                                  ? Colors.grey.shade300
                                  : (isDarkMode
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade300),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      filled: true,
                      fillColor:
                          _isWhiteBackground
                              ? Colors.grey.shade50
                              : (isDarkMode
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade50),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color:
                              _isWhiteBackground
                                  ? Colors.grey[700]
                                  : (isDarkMode
                                      ? Colors.grey
                                      : Colors.grey[700]),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.snackbar(
                        'Info',
                        'Fitur lupa password akan segera tersedia',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                    child: Text(
                      "Lupa Password?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Login button with animation
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(0.6, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blue.withOpacity(0.5),
                    ),
                    onPressed: _processLogin,
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Signup button with animation
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.4),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(0.7, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55),
                      side: BorderSide(color: Colors.blue, width: 1.5),
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Get.snackbar(
                        'Info',
                        'Fitur Daftar akan segera tersedia',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
