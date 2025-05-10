import 'package:flutter/material.dart';
import 'food_beverage_page.dart';
import 'package:get_storage/get_storage.dart';

class BookingPage extends StatefulWidget {
  final bool isWhiteBackground;

  const BookingPage({Key? key, required this.isWhiteBackground})
    : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int selectedPC = 10;
  List<int> availablePCs = [5, 7, 10, 12, 15, 18];
  String selectedTime = "14:00 — 16:00";
  List<String> availableTimes = [
    "10:00 — 12:00",
    "12:00 — 14:00",
    "14:00 — 16:00",
    "16:00 — 18:00",
    "18:00 — 20:00",
    "20:00 — 22:00",
  ];

  @override
  Widget build(BuildContext context) {
    // Mengambil status tema gelap/terang dari penyimpanan
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? true;

    // Tentukan warna berdasarkan tema dan pengaturan latar belakang putih
    Color backgroundColor =
        widget.isWhiteBackground
            ? Colors.white
            : (isDarkMode ? Colors.black : Colors.white);
    Color cardColor =
        widget.isWhiteBackground
            ? Colors.white
            : (isDarkMode ? Color(0xFF111827) : Colors.white);
    Color textColor =
        widget.isWhiteBackground
            ? Colors.black
            : (isDarkMode ? Colors.white : Colors.black);
    Color secondaryColor =
        widget.isWhiteBackground
            ? Color(0xFFEEEEEE)
            : (isDarkMode ? Color(0xFF1F2937) : Colors.grey.shade200);
    Color greyTextColor =
        widget.isWhiteBackground ? Colors.grey.shade700 : Colors.grey;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Halaman Booking",
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Text(
                  "4G",
                  style: TextStyle(color: greyTextColor, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Booking Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      widget.isWhiteBackground
                          ? Border.all(color: Colors.grey.shade300)
                          : null,
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Pilih PC & Waktu",
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _showPCAndTimeSelection();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "PC ",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "$selectedPC",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Opacity(
                                  opacity: 0.7,
                                  child: Text(
                                    selectedTime,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Makanan & Minuman
                    Text(
                      "Makanan & Minuman",
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodBeveragePage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Makanan & Minuman",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Layanan Section
                    Text(
                      "Layanan",
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Michael",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "michael@example.com",
                                style: TextStyle(
                                  color: greyTextColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Riwayat Pemesanan
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Riwayat Pemesanan",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // Confirm Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          _showBookingConfirmation();
                        },
                        child: Text(
                          "Konfirmasi Booking",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPCAndTimeSelection() {
    // Mengambil status tema
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? true;

    // Warna untuk bottom sheet berdasarkan tema dan pengaturan latar belakang putih
    Color bottomSheetColor =
        widget.isWhiteBackground
            ? Colors.white
            : (isDarkMode ? Color(0xFF111827) : Colors.white);
    Color textColor =
        widget.isWhiteBackground
            ? Colors.black
            : (isDarkMode ? Colors.white : Colors.black);
    Color itemColor =
        widget.isWhiteBackground
            ? Color(0xFFEEEEEE)
            : (isDarkMode ? Color(0xFF1F2937) : Colors.grey.shade200);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 400,
              decoration: BoxDecoration(
                color: bottomSheetColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pilih PC",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          availablePCs.map((pc) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPC = pc;
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color:
                                      selectedPC == pc
                                          ? Colors.blue
                                          : itemColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "$pc",
                                    style: TextStyle(
                                      color:
                                          selectedPC == pc
                                              ? Colors.white
                                              : textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Pilih Waktu",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          availableTimes.map((time) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTime = time;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      selectedTime == time
                                          ? Colors.blue
                                          : itemColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    color:
                                        selectedTime == time
                                            ? Colors.white
                                            : textColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            // Update parent state
                            this.setState(() {});
                          });
                        },
                        child: Text(
                          "Pilih",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showBookingConfirmation() {
    // Mengambil status tema
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? true;

    // Warna untuk dialog berdasarkan tema dan pengaturan latar belakang putih
    Color dialogColor =
        widget.isWhiteBackground
            ? Colors.white
            : (isDarkMode ? Color(0xFF111827) : Colors.white);
    Color textColor =
        widget.isWhiteBackground
            ? Colors.black
            : (isDarkMode ? Colors.white : Colors.black);
    Color greyTextColor =
        widget.isWhiteBackground ? Colors.grey.shade700 : Colors.grey;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: dialogColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Konfirmasi Booking",
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _confirmationItem("PC", "$selectedPC", textColor, greyTextColor),
              _confirmationItem(
                "Waktu",
                selectedTime,
                textColor,
                greyTextColor,
              ),
              _confirmationItem(
                "Tanggal",
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                textColor,
                greyTextColor,
              ),
              _confirmationItem("Total", "Rp 30.000", textColor, greyTextColor),
              SizedBox(height: 16),
              Text(
                "Apakah data booking sudah benar?",
                style: TextStyle(color: textColor, fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Batal", style: TextStyle(color: greyTextColor)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Booking berhasil!"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text("Konfirmasi"),
            ),
          ],
        );
      },
    );
  }

  Widget _confirmationItem(
    String label,
    String value,
    Color textColor,
    Color greyTextColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: greyTextColor, fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
