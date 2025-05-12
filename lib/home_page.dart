import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class HomePage extends StatefulWidget {
  final bool isWhiteBackground;

  const HomePage({Key? key, this.isWhiteBackground = false}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showPCDetail(String title, String spec, String price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              widget.isWhiteBackground ? Colors.white : Color(0xFF1F2937),
          title: Text(
            title,
            style: TextStyle(
              color: widget.isWhiteBackground ? Colors.black : Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            // Added scrolling here too
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(spec, style: TextStyle(color: Colors.grey, fontSize: 14)),
                SizedBox(height: 10),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Fitur tambahan:\n"
                  "- Reguler: Ideal untuk gaming ringan dan pekerjaan sehari-hari. Cocok untuk pengguna yang membutuhkan performa solid dengan harga terjangkau.\n"
                  "- VIP: Dirancang untuk pengalaman gaming yang lebih mulus dan grafis yang lebih tajam. Cocok untuk game AAA dan multitasking.\n"
                  "- VVIP: Performance top-tier untuk gaming kelas berat, video editing, dan pekerjaan intensif lainnya. Monitor curved memberikan kenyamanan visual lebih.\n"
                  "- Battle Arena: Dilengkapi dengan 2 private rooms yang masing-masing bisa menampung 5 PC, cocok untuk permainan kompetitif dan turnamen. Pengalaman gaming tanpa gangguan dengan perangkat premium.",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Tutup", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isWhiteBackground ? Colors.white : Colors.black,
      body: SafeArea(
        // Added SafeArea for better layout
        child: SingleChildScrollView(
          // Make the main content scrollable
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kategori PC",
                  style: TextStyle(
                    color:
                        widget.isWhiteBackground ? Colors.black : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    pcCategoryBox(
                      "Reguler",
                      Icons.computer,
                      () => showPCDetail(
                        "Reguler",
                        "Processor: Intel Core i5-10400\n"
                            "GPU: NVIDIA GTX 1650\n"
                            "RAM: 16GB DDR4\n"
                            "Monitor: 24\" 144Hz\n"
                            "Storage: SSD 256GB\n"
                            "Harga: Rp5.000 / jam\n",
                        "Rp5.000 / jam",
                      ),
                    ),
                    pcCategoryBox(
                      "VIP",
                      Icons.star,
                      () => showPCDetail(
                        "VIP",
                        "Processor: Intel Core i5-12400F\n"
                            "GPU: NVIDIA RTX 2060\n"
                            "RAM: 16GB DDR4\n"
                            "Monitor: 27\" 180Hz\n"
                            "Storage: SSD 512GB\n"
                            "Harga: Rp7.000 / jam\n",
                        "Rp7.000 / jam",
                      ),
                    ),
                    pcCategoryBox(
                      "VVIP",
                      Icons.workspace_premium,
                      () => showPCDetail(
                        "VVIP",
                        "Processor: Intel Core i7-12700KF\n"
                            "GPU: NVIDIA RTX 3070\n"
                            "RAM: 32GB DDR4\n"
                            "Monitor: 27\" 240Hz Curved\n"
                            "Storage: SSD 1TB NVMe\n"
                            "Harga: Rp10.000 / jam\n",
                        "Rp10.000 / jam",
                      ),
                    ),
                    pcCategoryBox(
                      "Battle Arena",
                      Icons.sports_esports,
                      () => showPCDetail(
                        "Battle Arena",
                        "Processor: AMD Ryzen 7 5800X\n"
                            "GPU: NVIDIA RTX 4060\n"
                            "RAM: 32GB DDR4\n"
                            "Monitor: 32\" 240Hz Curved Premium\n"
                            "Storage: SSD 1TB NVMe\n"
                            "Harga: Rp15.000 / jam\n",
                        "Rp15.000 / jam",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  "Paket Malam",
                  style: TextStyle(
                    color:
                        widget.isWhiteBackground ? Colors.black : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // Remove the Expanded widget here
                Column(
                  children: [
                    nightPackageTile("Reguler", "Rp15.000"),
                    nightPackageTile("VIP", "Rp23.000"),
                    nightPackageTile("VVIP", "Rp27.000"),
                    nightPackageTile("Battle Arena", "Rp35.000"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pcCategoryBox(String title, IconData icon, VoidCallback onTap) {
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

  Widget nightPackageTile(String title, String price) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              widget.isWhiteBackground
                  ? [Colors.lightBlue.shade100, Colors.blue.shade100]
                  : [Colors.blue.shade600, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Main dari jam 22.00 - 06.00 hanya $price!",
            style: TextStyle(
              color: widget.isWhiteBackground ? Colors.black : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Paket malam untuk kategori $title.",
            style: TextStyle(
              color: widget.isWhiteBackground ? Colors.black54 : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
