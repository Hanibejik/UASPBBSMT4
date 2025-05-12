import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';
import 'game_service.dart';

class ServicesPage extends StatefulWidget {
  final bool isWhiteBackground;

  const ServicesPage({Key? key, this.isWhiteBackground = false})
    : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  void showServiceDetail(String title, String content) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor:
                widget.isWhiteBackground ? Colors.white : Color(0xFF1F2937),
            title: Text(
              title,
              style: TextStyle(
                color: widget.isWhiteBackground ? Colors.black : Colors.white,
              ),
            ),
            content: Text(
              content,
              style: TextStyle(
                color:
                    widget.isWhiteBackground ? Colors.black87 : Colors.white70,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Tutup", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
    );
  }

  void showGameMenu() {
    final List<Map<String, String>> games = [
      {"nama": "Ayodance", "gambar": "assets/images/game/ayodance.jpg"},
      {"nama": "Counter Strike 2", "gambar": "assets/images/game/cs.jpg"},
      {"nama": "Dota 2", "gambar": "assets/images/game/dota.jpg"},
      {"nama": "Epic Game", "gambar": "assets/images/game/epicgame.jpg"},
      {"nama": "Steam", "gambar": "assets/images/game/steam.jpg"},
      {"nama": "Lost Saga Origin", "gambar": "assets/images/game/ls.jpg"},
      {"nama": "Pointblank", "gambar": "assets/images/game/pb.jpg"},
      {"nama": "Roblox", "gambar": "assets/images/game/roblox.jpg"},
      {"nama": "Valorant", "gambar": "assets/images/game/valo.jpg"},
      {"nama": "Fortnite", "gambar": "assets/images/game/fn.jpg"},
    ];

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor:
                widget.isWhiteBackground ? Colors.white : Color(0xFF1F2937),
            title: Text(
              "Daftar Game",
              style: TextStyle(
                color: widget.isWhiteBackground ? Colors.black : Colors.white,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ...games.map(
                    (game) => ListTile(
                      leading: Image.asset(
                        game["gambar"]!,
                        width: 36,
                        height: 36,
                        errorBuilder:
                            (_, __, ___) =>
                                Icon(Icons.videogame_asset, color: Colors.grey),
                      ),
                      title: Text(
                        game["nama"]!,
                        style: TextStyle(
                          color:
                              widget.isWhiteBackground
                                  ? Colors.black87
                                  : Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color:
                        widget.isWhiteBackground
                            ? Colors.black
                            : Colors.white70,
                  ),
                  ListTile(
                    leading: Icon(Icons.add_circle_outline, color: Colors.blue),
                    title: Text(
                      "Tambah Game",
                      style: TextStyle(
                        color:
                            widget.isWhiteBackground
                                ? Colors.black
                                : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              backgroundColor:
                                  widget.isWhiteBackground
                                      ? Colors.white
                                      : Color(0xFF1F2937),
                              title: Text(
                                "Tambah Game",
                                style: TextStyle(
                                  color:
                                      widget.isWhiteBackground
                                          ? Colors.black
                                          : Colors.white,
                                ),
                              ),
                              content: Text(
                                "Silakan ke operator warnet untuk menginstall game Anda.",
                                style: TextStyle(
                                  color:
                                      widget.isWhiteBackground
                                          ? Colors.black87
                                          : Colors.white70,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    "Tutup",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Tutup", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
    );
  }

  Widget serviceBox(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: ZoDottedBorder(
        animate: true,
        borderRadius: 10,
        dashLength: 10,
        gapLength: 5,
        strokeWidth: 3,
        color: Colors.blue,
        animationDuration: Duration(seconds: 4),
        borderStyle: BorderStyleType.monochrome,
        child: Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                widget.isWhiteBackground
                    ? Colors.grey.shade100
                    : Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: widget.isWhiteBackground ? Colors.black : Colors.white,
              ),
              SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  color: widget.isWhiteBackground ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isWhiteBackground ? Colors.white : Colors.black,
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: MediaQuery.of(context).padding.top + 16.0,
          bottom: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Layanan Warnet",
              style: TextStyle(
                color: widget.isWhiteBackground ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  serviceBox("WiFi", Icons.wifi, () {
                    showServiceDetail(
                      "WiFi Warnet",
                      "ID: warnet_wifi\nPassword: 12345678",
                    );
                  }),
                  serviceBox("Layanan Game", Icons.videogame_asset, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => GameServicePage(
                              isWhiteBackground: widget.isWhiteBackground,
                            ),
                      ),
                    );
                  }),

                  serviceBox("Charge", Icons.battery_charging_full, () {
                    showServiceDetail(
                      "Layanan Charge",
                      "Harga: Rp 2.000 / jam\nSilakan lakukan transaksi di kasir.",
                    );
                  }),
                  serviceBox("Stream Support", Icons.stream, () {
                    showServiceDetail(
                      "Stream Support",
                      "Fasilitas tambahan:\n- Webcam HD\n- Microphone Eksternal\n- Screen Recorder\nHarga: Rp 8.000 / jam\nSilakan lakukan transaksi di kasir.",
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
