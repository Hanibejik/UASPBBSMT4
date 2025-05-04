import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String password;
  final VoidCallback onToggleTheme;

  const ProfileScreen({
    required this.username,
    required this.password,
    required this.onToggleTheme,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: onToggleTheme,
            tooltip: 'Ganti Tema',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Username: $username"),
            Text("Password: $password"),
            ElevatedButton(
              onPressed: () {
                final box = GetStorage();
                box.remove('username');
                Get.offAll(() => LoginScreen(onToggleTheme: onToggleTheme));
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
