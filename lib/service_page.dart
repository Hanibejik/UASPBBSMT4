import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';
import 'package:url_launcher/url_launcher.dart';
import 'game_service.dart';

class ServicesPage extends StatefulWidget {
  final bool isWhiteBackground;

  const ServicesPage({Key? key, this.isWhiteBackground = false})
    : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final List<Map<String, String>> lokasiWarnet = [
    {
      "nama": "Warnet Solo Net",
      "alamat": "Jl. Slamet Riyadi No. 45, Solo",
      "url":
          "https://www.google.com/maps/search/?api=1&query=Jl.+Slamet+Riyadi+No.+45,+Solo",
    },
    {
      "nama": "GigaNet Solo",
      "alamat": "Jl. Adi Sucipto No. 12, Solo",
      "url":
          "https://www.google.com/maps/search/?api=1&query=Jl.+Adi+Sucipto+No.+12,+Solo",
    },
    {
      "nama": "SpeedNet Gaming",
      "alamat": "Jl. Veteran No. 10, Solo",
      "url":
          "https://www.google.com/maps/search/?api=1&query=Jl.+Veteran+No.+10,+Solo",
    },
    {
      "nama": "ArenaNet Solo",
      "alamat": "Jl. Dr. Radjiman No. 3, Solo",
      "url":
          "https://www.google.com/maps/search/?api=1&query=Jl.+Dr.+Radjiman+No.+3,+Solo",
    },
    {
      "nama": "NetZone Solo",
      "alamat": "Jl. Yos Sudarso No. 88, Solo",
      "url":
          "https://www.google.com/maps/search/?api=1&query=Jl.+Yos+Sudarso+No.+88,+Solo",
    },
  ];

  void showServiceDetail(String title, String content) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor:
                widget.isWhiteBackground
                    ? Colors.white
                    : const Color(0xFF1F2937),
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
                child: const Text(
                  "Tutup",
                  style: TextStyle(color: Colors.blue),
                ),
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
        animationDuration: const Duration(seconds: 4),
        borderStyle: BorderStyleType.monochrome,
        child: Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                widget.isWhiteBackground
                    ? Colors.grey.shade100
                    : const Color(0xFF1F2937),
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
              const SizedBox(height: 6),
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

  Future<void> launchUrlExternal(String url) async {
    try {
      final encodedUrl = Uri.encodeFull(url);
      final Uri uri = Uri.parse(encodedUrl);

      debugPrint("Mencoba buka URL: $encodedUrl");

      final can = await canLaunchUrl(uri);
      debugPrint("Hasil canLaunchUrl: $can");

      if (can) {
        final success = await launchUrl(uri, mode: LaunchMode.platformDefault);
        debugPrint("Hasil launchUrl: $success");
      } else {
        debugPrint('GAGAL buka: $uri');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka Google Maps')),
        );
      }
    } catch (e) {
      debugPrint('EXCEPTION saat membuka URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan saat membuka Maps')),
      );
    }
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
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
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
                    const SizedBox(height: 24),
                    Text(
                      "Lokasi Warnet",
                      style: TextStyle(
                        color:
                            widget.isWhiteBackground
                                ? Colors.black
                                : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...lokasiWarnet.map((lokasi) {
                      return Card(
                        color:
                            widget.isWhiteBackground
                                ? Colors.white
                                : const Color(0xFF1F2937),
                        child: ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          title: Text(
                            lokasi["nama"]!,
                            style: TextStyle(
                              color:
                                  widget.isWhiteBackground
                                      ? Colors.black
                                      : Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            lokasi["alamat"]!,
                            style: TextStyle(
                              color:
                                  widget.isWhiteBackground
                                      ? Colors.black54
                                      : Colors.white70,
                            ),
                          ),
                          onTap: () => launchUrlExternal(lokasi["url"] ?? ""),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
