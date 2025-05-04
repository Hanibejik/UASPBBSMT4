import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const SettingsPage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Mode Gelap"),
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                onToggleTheme();
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifikasi"),
            trailing: Switch(value: true, onChanged: (value) {}),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Bahasa"),
            subtitle: Text("Indonesia"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Tentang Aplikasi"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Bantuan"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          SizedBox(height: 20),
          Center(
            child: Text("Versi 1.0.0", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
