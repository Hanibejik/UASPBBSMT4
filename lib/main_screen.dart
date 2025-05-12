import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'home_page.dart';
import 'booking_page.dart';
import 'service_page.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final String username;
  final VoidCallback onToggleTheme;

  const MainScreen({
    Key? key,
    required this.username,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;
  bool _isWhiteBackground = false;

  @override
  void initState() {
    super.initState();

    // Load background preference if previously saved
    final box = GetStorage();
    _isWhiteBackground = box.read('isWhiteBackground') ?? false;

    _updatePages();
  }

  void _updatePages() {
    _pages = [
      HomePage(isWhiteBackground: _isWhiteBackground),
      BookingPage(isWhiteBackground: _isWhiteBackground),
      ServicesPage(isWhiteBackground: _isWhiteBackground),
      ProfileScreen(
        username: widget.username,
        onToggleTheme: widget.onToggleTheme,
        isWhiteBackground: _isWhiteBackground,
      ),
    ];
  }

  void _toggleBackground() {
    setState(() {
      _isWhiteBackground = !_isWhiteBackground;
      // Save preference to storage
      final box = GetStorage();
      box.write('isWhiteBackground', _isWhiteBackground);

      // Update pages with new background setting
      _updatePages();

      // Show feedback to user
      Get.snackbar(
        'Info',
        _isWhiteBackground
            ? 'Background diubah ke putih'
            : 'Background kembali ke tema default',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil nilai tema dari penyimpanan GetStorage
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? true;

    // Override background color if white background is selected
    Color backgroundColor =
        _isWhiteBackground
            ? Colors.white
            : (isDarkMode ? Colors.black : Colors.white);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor:
            _isWhiteBackground
                ? Colors.white
                : (isDarkMode ? const Color(0xFF111827) : Colors.blue),
        title: Text(
          'Cafe & Warnet Solution',
          style: TextStyle(
            color: _isWhiteBackground ? Colors.black : Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: _isWhiteBackground ? Colors.black : Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isWhiteBackground
                  ? Icons.invert_colors_off
                  : Icons.invert_colors,
              color: _isWhiteBackground ? Colors.black : Colors.white,
            ),
            onPressed: _toggleBackground,
            tooltip: 'Ganti Background',
          ),
        ],
      ),

      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color:
              _isWhiteBackground
                  ? Colors.white
                  : (isDarkMode ? Color(0xFF111827) : Colors.white),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor:
                _isWhiteBackground
                    ? Colors.white
                    : (isDarkMode ? Color(0xFF111827) : Colors.white),
            selectedItemColor:
                _isWhiteBackground
                    ? Colors.blue
                    : (isDarkMode ? Colors.blue : Colors.black),
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Booking',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Layanan'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.wifi_tethering, size: 30, color: Colors.white),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color:
                        _isWhiteBackground
                            ? Colors.white
                            : (isDarkMode ? Color(0xFF111827) : Colors.white),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cafe & Warnet Solution',
                        style: TextStyle(
                          color:
                              _isWhiteBackground
                                  ? Colors.black
                                  : (isDarkMode ? Colors.white : Colors.black),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          color:
                              _isWhiteBackground
                                  ? Colors.black
                                  : (isDarkMode ? Colors.grey : Colors.black),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
