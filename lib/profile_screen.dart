import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'login_screen.dart';

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
    return Scaffold(
      backgroundColor: isWhiteBackground ? Colors.white : Colors.black,
      // Removed appBar completely to eliminate title bar and 4G indicator
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Added SafeArea and some extra padding at the top to compensate for missing AppBar
              SizedBox(height: MediaQuery.of(context).padding.top),

              // Profile Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isWhiteBackground ? Colors.white : Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "M",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                color:
                                    isWhiteBackground
                                        ? Colors.black
                                        : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "user@example.com",
                              style: TextStyle(
                                color:
                                    isWhiteBackground
                                        ? Colors.black
                                        : Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            // Handle edit profile
                          },
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              color:
                                  isWhiteBackground
                                      ? Colors.blue
                                      : Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Account Settings
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isWhiteBackground ? Colors.white : Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Settings",
                      style: TextStyle(
                        color: isWhiteBackground ? Colors.black : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Balance
                    ProfileMenuItem(
                      icon: Icons.add_circle,
                      iconColor: Colors.blue,
                      title: "Balance",
                      value: "Rp 50.000",
                      showDivider: true,
                      isWhiteBackground: isWhiteBackground,
                    ),

                    // Transaction History
                    ProfileMenuItem(
                      icon: Icons.history,
                      iconColor: Colors.grey,
                      title: "Transaction History",
                      hasNavigation: true,
                      showDivider: true,
                      isWhiteBackground: isWhiteBackground,
                    ),

                    // Payment Methods
                    ProfileMenuItem(
                      icon: Icons.payment,
                      iconColor: Colors.blue,
                      title: "Payment Methods",
                      hasNavigation: true,
                      showDivider: true,
                      isWhiteBackground: isWhiteBackground,
                    ),

                    // Logout - Modified to go directly to login screen
                    GestureDetector(
                      onTap: () {
                        final box = GetStorage();
                        box.remove('username');
                        box.remove('password');

                        // Direct navigation to login screen without splash
                        Get.offAll(
                          () => LoginScreen(onToggleTheme: onToggleTheme),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.logout,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Notification Settings
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isWhiteBackground ? Colors.white : Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification Settings",
                      style: TextStyle(
                        color: isWhiteBackground ? Colors.black : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    // App Notifications
                    ToggleSettingItem(
                      icon: Icons.notifications,
                      title: "App Notifications",
                      value: true,
                      showDivider: true,
                      isWhiteBackground: isWhiteBackground,
                    ),

                    // Promo Notifications
                    ToggleSettingItem(
                      icon: Icons.local_offer,
                      title: "Promo Notifications",
                      value: true,
                      showDivider: true,
                      isWhiteBackground: isWhiteBackground,
                    ),

                    // System Notifications
                    ToggleSettingItem(
                      icon: Icons.system_update,
                      title: "System Notifications",
                      value: false,
                      isWhiteBackground: isWhiteBackground,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // About
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isWhiteBackground ? Colors.white : Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(
                        color: isWhiteBackground ? Colors.black : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    ProfileMenuItem(
                      icon: Icons.info,
                      iconColor: Colors.blue,
                      title: "About Us",
                      hasNavigation: true,
                      showDivider: true,
                      isWhiteBackground: isWhiteBackground,
                    ),

                    ProfileMenuItem(
                      icon: Icons.help,
                      iconColor: Colors.blue,
                      title: "Help & Support",
                      hasNavigation: true,
                      showDivider: true,
                      isWhiteBackground: isWhiteBackground,
                    ),

                    ProfileMenuItem(
                      icon: Icons.privacy_tip,
                      iconColor: Colors.blue,
                      title: "Privacy Policy",
                      hasNavigation: true,
                      isWhiteBackground: isWhiteBackground,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Center(
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? value;
  final bool hasNavigation;
  final bool showDivider;
  final bool isWhiteBackground;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.value,
    this.hasNavigation = false,
    this.showDivider = false,
    required this.isWhiteBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(child: Icon(icon, color: iconColor, size: 20)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isWhiteBackground ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              if (value != null)
                Text(
                  value!,
                  style: TextStyle(
                    color: isWhiteBackground ? Colors.black : Colors.white,
                    fontSize: 14,
                  ),
                ),
              if (hasNavigation)
                Icon(
                  Icons.arrow_forward_ios,
                  color: isWhiteBackground ? Colors.black : Colors.white,
                  size: 14,
                ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color:
                isWhiteBackground
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white,
          ),
      ],
    );
  }
}

class ToggleSettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final bool showDivider;
  final bool isWhiteBackground;

  const ToggleSettingItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    this.showDivider = false,
    required this.isWhiteBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color:
                      isWhiteBackground
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: isWhiteBackground ? Colors.blue : Colors.blue,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isWhiteBackground ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: (newValue) {
                  // Handle toggle
                },
                activeColor: Colors.blue,
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color:
                isWhiteBackground
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white,
          ),
      ],
    );
  }
}
