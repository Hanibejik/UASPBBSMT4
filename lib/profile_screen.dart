import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String password;
  final VoidCallback onToggleTheme;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.password,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
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
            Text(
              'Username: $username',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Password: $password',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali ke Halaman Login'),
            ),
          ],
        ),
      ),
    );
  }
}
