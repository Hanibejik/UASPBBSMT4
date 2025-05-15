import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TopUpScreen extends StatefulWidget {
  final bool isWhiteBackground;

  const TopUpScreen({Key? key, required this.isWhiteBackground})
    : super(key: key);

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  String _method = '';

  @override
  Widget build(BuildContext context) {
    final isWhite = widget.isWhiteBackground;
    final textColor = isWhite ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Isi Saldo'),
        backgroundColor: isWhite ? Colors.white : Colors.black,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: isWhite ? Colors.white : Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Metode Pembayaran",
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Text('Cash'),
                    selected: _method == 'cash',
                    onSelected: (_) => setState(() => _method = 'cash'),
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: _method == 'cash' ? Colors.white : textColor,
                    ),
                    backgroundColor:
                        isWhite ? Colors.grey.shade200 : Colors.grey.shade800,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: Text('Transfer'),
                    selected: _method == 'transfer',
                    onSelected: (_) => setState(() => _method = 'transfer'),
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: _method == 'transfer' ? Colors.white : textColor,
                    ),
                    backgroundColor:
                        isWhite ? Colors.grey.shade200 : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            if (_method == 'cash') ...[
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isWhite ? Colors.grey.shade100 : Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Silakan datang ke kasir untuk melakukan pembayaran secara tunai.",
                  style: TextStyle(color: textColor, fontSize: 15),
                ),
              ),
            ],

            if (_method == 'transfer') ...[
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isWhite ? Colors.grey.shade100 : Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Silakan transfer ke salah satu rekening berikut:",
                      style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "🔹 BCA\n   0790512898\n   A/N Hani Ibrahim",
                      style: TextStyle(color: textColor, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "🔹 BRI\n   1378 0100 4200 539\n   A/N Hani Ibrahim",
                      style: TextStyle(color: textColor, fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Setelah transfer, silakan screenshot bukti transfer dan sertakan id member, kirim ke WhatsApp berikut:",
                      style: TextStyle(color: textColor, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        launchWhatsApp();
                      },
                      child: Text(
                        "👉 Klik di sini untuk kirim ke WhatsApp (0878-8878-0616)",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void launchWhatsApp() async {
    final url = 'https://wa.me/6287888780616';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar('Gagal', 'Tidak bisa membuka WhatsApp');
    }
  }
}
