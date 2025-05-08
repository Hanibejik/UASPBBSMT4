import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'settings_page.dart';
import 'home_page.dart';
import 'message_screen.dart';

class MainScreen extends StatefulWidget {
  final String username;
  final String password;
  final VoidCallback onToggleTheme;

  const MainScreen({
    Key? key,
    required this.username,
    required this.password,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _motionTabBarController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Universitas Duta Bangsa"),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
            tooltip: 'Ganti Tema',
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              final box = GetStorage();
              box.remove('username');
              box.remove('password');

              Get.offAll(
                () => LoginScreen(onToggleTheme: widget.onToggleTheme),
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Home",
        useSafeArea: true,
        labels: const ["Home", "Message", "Profile", "Settings"],
        icons: const [Icons.home, Icons.message, Icons.person, Icons.settings],

        badges: [
          null,

          const MotionBadgeWidget(
            isIndicator: false,
            color: Colors.red,
            size: 5,
            show: true,
          ),

          const MotionBadgeWidget(
            isIndicator: true,
            color: Colors.red,
            size: 5,
            show: true,
          ),

          null,
        ],

        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: <Widget>[
          HomePage(onToggleTheme: widget.onToggleTheme),
          MessageScreen(onToggleTheme: widget.onToggleTheme),
          ProfileScreen(
            username: widget.username,
            password: widget.password,
            onToggleTheme: widget.onToggleTheme,
          ),
          SettingsPage(onToggleTheme: widget.onToggleTheme),
        ],
      ),
    );
  }
}
