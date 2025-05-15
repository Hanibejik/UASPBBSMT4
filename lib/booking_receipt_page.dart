import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class BookingReceiptPage extends StatelessWidget {
  final Map<String, dynamic> booking;
  final bool isWhiteBackground;

  const BookingReceiptPage({
    Key? key,
    required this.booking,
    // Secara default ambil dari storage, tetapi bisa dioverride
    this.isWhiteBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final bool isDarkMode = box.read('isDarkMode') ?? true;
    final bool actualWhiteBackground =
        box.read('isWhiteBackground') ?? isWhiteBackground;

    // Definisikan warna berdasarkan tema
    Color backgroundColor =
        actualWhiteBackground
            ? Colors.white
            : (isDarkMode ? Colors.black : Colors.white);
    Color cardColor =
        actualWhiteBackground
            ? Colors.white
            : (isDarkMode ? const Color(0xFF111827) : Colors.white);
    Color textColor =
        actualWhiteBackground
            ? Colors.black
            : (isDarkMode ? Colors.white : Colors.black);
    Color secondaryColor =
        actualWhiteBackground
            ? Color(0xFFEEEEEE)
            : (isDarkMode ? const Color(0xFF1F2937) : Colors.grey.shade200);
    Color greyTextColor =
        actualWhiteBackground ? Colors.grey.shade700 : Colors.grey;

    final orderedItems = booking['orderedItems'] as List<dynamic>;
    final bool hasPC = booking['pc'] != null;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          hasPC ? 'Struk Booking' : 'Struk Pesanan',
          style: TextStyle(
            color: actualWhiteBackground ? Colors.black : Colors.white,
          ),
        ),
        backgroundColor:
            actualWhiteBackground
                ? Colors.white
                : (isDarkMode ? const Color(0xFF111827) : Colors.blue),
        iconTheme: IconThemeData(
          color: actualWhiteBackground ? Colors.black : Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "📅 ${booking['date'].toString().split('.')[0]}",
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              SizedBox(height: 16),

              // Only show PC info if a PC was selected
              if (hasPC) ...[
                _infoRow(
                  "Kategori",
                  booking['category'],
                  textColor,
                  greyTextColor,
                ),
                _infoRow(
                  "Nomor PC",
                  "PC ${booking['pc']}",
                  textColor,
                  greyTextColor,
                ),
                _infoRow(
                  "Durasi",
                  booking['duration'],
                  textColor,
                  greyTextColor,
                ),
                _infoRow(
                  "Biaya PC",
                  "Rp ${booking['pcTotal']}",
                  textColor,
                  greyTextColor,
                ),
                Divider(color: greyTextColor),
              ],

              // Only show food items if any were ordered
              if (orderedItems.isNotEmpty) ...[
                Text(
                  "🍽️ Pesanan Makanan & Minuman",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 8),
                ...orderedItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${item['name']} x${item['count']}",
                          style: TextStyle(color: greyTextColor),
                        ),
                        Text(
                          "Rp ${(item['price'] as int) * (item['count'] as int)}",
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: greyTextColor),
                _infoRow(
                  "Total F&B",
                  "Rp ${booking['foodTotal']}",
                  textColor,
                  greyTextColor,
                ),
              ],

              Divider(thickness: 2, color: greyTextColor),
              _infoRow(
                "Total Keseluruhan",
                "Rp ${booking['grandTotal']}",
                Colors.blue,
                textColor,
                isBold: true,
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Selesai",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value,
    Color textColor,
    Color greyTextColor, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: isBold ? textColor : greyTextColor),
          ),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
