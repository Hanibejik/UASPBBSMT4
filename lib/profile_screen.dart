import 'package:flutter/material.dart';
import 'package:flutter_application_1/just_audio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'splash_screen.dart';
import 'edit_profile_screen.dart';
import 'top_up_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final VoidCallback onToggleTheme;
  final bool isWhiteBackground;

  const ProfileScreen({
    Key? key,
    required this.username,
    required this.onToggleTheme,
    required this.isWhiteBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final int balance = box.read('balance') ?? 0;
    final userId = box.read('username') ?? 'Guest';
    final email = box.read('loggedInEmail') ?? 'email@tidakdiketahui.com';

    return Scaffold(
      backgroundColor: isWhiteBackground ? Colors.white : Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            // Profile Card
            Container(
              decoration: BoxDecoration(
                color:
                    isWhiteBackground ? Colors.white : const Color(0xFF111827),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    child: Text(
                      userId[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userId,
                          style: TextStyle(
                            color:
                                isWhiteBackground ? Colors.black : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: TextStyle(
                            color:
                                isWhiteBackground
                                    ? Colors.black54
                                    : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(
                        () => EditProfileScreen(
                          isWhiteBackground: isWhiteBackground,
                        ),
                      );
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: isWhiteBackground ? Colors.blue : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Account Settings
            _sectionTitle("Pengaturan Akun"),
            const SizedBox(height: 12),

            ProfileMenuItem(
              icon: Icons.account_balance_wallet,
              iconColor: Colors.green,
              title: "Saldo",
              value: "Rp $balance",
              isWhiteBackground: isWhiteBackground,
            ),

            _divider(),

            ProfileMenuItem(
              icon: Icons.history,
              iconColor: Colors.orange,
              title: "Histori Transaksi",
              hasNavigation: true,
              isWhiteBackground: isWhiteBackground,
            ),

            ProfileMenuItem(
              icon: Icons.add_circle,
              iconColor: Colors.teal,
              title: "Isi Saldo",
              hasNavigation: true,
              isWhiteBackground: isWhiteBackground,
              onTap: () {
                Get.to(() => TopUpScreen(isWhiteBackground: isWhiteBackground));
              },
            ),
            _divider(),

            const SizedBox(height: 24),

            _sectionTitle("Notifikasi"),
            const SizedBox(height: 12),

            ToggleSettingItem(
              icon: Icons.local_offer,
              title: "Notifikasi Promo",
              value: box.read('promoActive') ?? false, // default false
              isWhiteBackground: isWhiteBackground,
              onChanged: (val) {
                box.write('promoActive', val);
              },
            ),

            const SizedBox(height: 24),

            const SizedBox(height: 12),
            ToggleSettingItem(
              icon: Icons.music_note,
              title: "Backsound",
              value: AudioController.getMutedStatus() == false,
              isWhiteBackground: isWhiteBackground,
              onChanged: (val) {
                if (val) {
                  AudioController.unmute();
                } else {
                  AudioController.mute();
                }
              },
            ),

            // Logout
            GestureDetector(
              onTap: () {
                box.erase();
                Get.offAll(() => SplashScreen(onToggleTheme: onToggleTheme));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color:
                      isWhiteBackground
                          ? Colors.white
                          : const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 12),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(
                  color: isWhiteBackground ? Colors.grey : Colors.white60,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() =>
      Divider(color: isWhiteBackground ? Colors.grey.shade300 : Colors.white10);

  Widget _sectionTitle(String title) => Text(
    title,
    style: TextStyle(
      color: isWhiteBackground ? Colors.black : Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}

// Reusable Profile Menu Item
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? value;
  final bool hasNavigation;
  final bool isWhiteBackground;
  final VoidCallback? onTap; // ✅ Tambahkan ini

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.value,
    this.hasNavigation = false,
    required this.isWhiteBackground,
    this.onTap, // ✅ Tambahkan ini juga
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap, // ✅ Gunakan onTap di ListTile
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isWhiteBackground ? Colors.black : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          value != null
              ? Text(
                value!,
                style: TextStyle(
                  color: isWhiteBackground ? Colors.black : Colors.white,
                  fontSize: 14,
                ),
              )
              : hasNavigation
              ? Icon(
                Icons.arrow_forward_ios,
                color: isWhiteBackground ? Colors.black : Colors.white,
                size: 14,
              )
              : null,
    );
  }
}

// Reusable Toggle Setting Item
class ToggleSettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final bool isWhiteBackground;
  final ValueChanged<bool>? onChanged; // ✅

  const ToggleSettingItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.isWhiteBackground,
    this.onChanged, // ✅
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: CircleAvatar(
        backgroundColor: Colors.blue.withOpacity(0.1),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isWhiteBackground ? Colors.black : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      value: value,
      onChanged: onChanged, // ✅ Pakai parameter
      activeColor: Colors.blue,
    );
  }
}
