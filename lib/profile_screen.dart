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
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        username.isNotEmpty ? username[0].toUpperCase() : "U",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Mahasiswa Aktif",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Informasi Akun",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Username"),
                            subtitle: Text(username),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Password"),
                            subtitle: Text("●●●●●●●●"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Email"),
                            subtitle: Text(
                              "${username.toLowerCase()}@student.udb.ac.id",
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Nomor Telepon"),
                            subtitle: Text("0878 8878 0616"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    "Aktivitas Akademik",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.school,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Program Studi"),
                            subtitle: Text("Sistem Informasi"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Angkatan"),
                            subtitle: Text("2023"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.confirmation_number,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("NIM"),
                            subtitle: Text("230101103"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.logout),
                      label: Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
                      ),
                      onPressed: () {
                        final box = GetStorage();
                        box.remove('username');
                        box.remove('password');
                        Get.offAll(
                          () => LoginScreen(onToggleTheme: onToggleTheme),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
