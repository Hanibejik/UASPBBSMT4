import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditProfileScreen extends StatefulWidget {
  final bool isWhiteBackground;

  const EditProfileScreen({super.key, required this.isWhiteBackground});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _box = GetStorage();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = _box.read('userEmail') ?? '';
    _passwordController.text = _box.read('password') ?? '';
  }

  void _saveChanges() {
    final newEmail = _emailController.text.trim();
    final newPassword = _passwordController.text;

    if (newEmail.isEmpty || newPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan password tidak boleh kosong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _box.write('userEmail', newEmail);
    _box.write('loggedInEmail', newEmail);
    _box.write('password', newPassword);

    Get.snackbar(
      'Sukses',
      'Profil berhasil diperbarui',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    // Tutup layar edit
    Future.delayed(Duration(seconds: 1), () => Get.back());
  }

  @override
  Widget build(BuildContext context) {
    final isWhite = widget.isWhiteBackground;

    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        elevation: 0,
        title: Text(
          'Edit Profil',
          style: TextStyle(
            color: isWhite ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: isWhite ? Colors.black : Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              style: TextStyle(color: isWhite ? Colors.black : Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: isWhite ? Colors.grey[700] : Colors.grey[400],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: isWhite ? Colors.black : Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: isWhite ? Colors.grey[700] : Colors.grey[400],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: Icon(Icons.save),
              label: Text("Simpan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
