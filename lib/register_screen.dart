import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const RegisterScreen({super.key, required this.onToggleTheme});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
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
    _userIdController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  void _processRegister() {
    // Validasi input
    if (_userIdController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'ID, Email, dan Password tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validasi email
    if (!_validateEmail(_emailController.text)) {
      Get.snackbar(
        'Error',
        'Format email tidak valid',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validasi password
    if (_passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password minimal 6 karakter',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validasi konfirmasi password
    if (_passwordController.text != _confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Password dan konfirmasi password tidak cocok',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Simpan data registrasi
    final box = GetStorage();
    box.write('userId', _userIdController.text);
    box.write('userEmail', _emailController.text);
    box.write('password', _passwordController.text);

    // Tampilkan pesan sukses
    Get.snackbar(
      'Berhasil',
      'Pendaftaran berhasil, silakan login',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );

    // Arahkan ke halaman login setelah 2 detik
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => LoginScreen(onToggleTheme: widget.onToggleTheme));
    });
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
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Safe area
                SizedBox(height: MediaQuery.of(context).padding.top + 20),

                // Logo with animation
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 1),
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        width: 100,
                        height: 100,
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
                                  size: 50,
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
                SizedBox(height: 40),

                Text(
                  "DAFTAR AKUN",
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

                // User ID Field
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-0.2, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(0.1, 0.5, curve: Curves.easeOut),
                    ),
                  ),
                  child: TextField(
                    controller: _userIdController,
                    style: TextStyle(
                      color:
                          _isWhiteBackground
                              ? Colors.black
                              : (isDarkMode ? Colors.white : Colors.black),
                    ),
                    decoration: InputDecoration(
                      labelText: 'ID Pengguna',
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
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
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
                const SizedBox(height: 16),

                // Email Field
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
                    keyboardType: TextInputType.emailAddress,
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
                const SizedBox(height: 16),

                // Password Field
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.2, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(0.3, 0.7, curve: Curves.easeOut),
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

                // Confirm Password Field
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
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    style: TextStyle(
                      color:
                          _isWhiteBackground
                              ? Colors.black
                              : (isDarkMode ? Colors.white : Colors.black),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Password',
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
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.blue),
                      filled: true,
                      fillColor:
                          _isWhiteBackground
                              ? Colors.grey.shade50
                              : (isDarkMode
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade50),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
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
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Daftar button with animation
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
                    onPressed: _processRegister,
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun? ",
                      style: TextStyle(
                        color:
                            _isWhiteBackground
                                ? Colors.black
                                : (isDarkMode ? Colors.white : Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(
                          () =>
                              LoginScreen(onToggleTheme: widget.onToggleTheme),
                        );
                      },
                      child: Text(
                        "Masuk",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
