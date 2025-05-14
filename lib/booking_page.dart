import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'food_beverage_page.dart';

// Buat class RxList global untuk menyimpan pesanan makanan
class FoodOrderController extends GetxController {
  static FoodOrderController get to => Get.find();

  final RxList<Map<String, dynamic>> orderedItems =
      <Map<String, dynamic>>[].obs;

  // Tambahkan RxList untuk menyimpan riwayat booking
  final RxList<Map<String, dynamic>> bookingHistory =
      <Map<String, dynamic>>[].obs;

  void clearOrders() {
    orderedItems.clear();
  }

  int get totalFoodPrice => orderedItems.fold(
    0,
    (sum, item) => sum + (item['price'] as int) * (item['count'] as int),
  );

  int get totalItems =>
      orderedItems.fold(0, (sum, item) => sum + (item['count'] as int));

  void addOrderedItems(List<Map<String, dynamic>> items) {
    // Filter hanya item yang jumlahnya > 0
    final selectedItems = items.where((item) => item['count'] > 0).toList();
    orderedItems.clear();
    orderedItems.addAll(selectedItems);
  }

  // Fungsi untuk menambahkan booking ke riwayat
  void addBookingToHistory(Map<String, dynamic> booking) {
    bookingHistory.add(booking);
  }
}

class BookingPage extends StatefulWidget {
  final bool isWhiteBackground;

  const BookingPage({Key? key, required this.isWhiteBackground})
    : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String selectedCategory = 'Reguler';
  int selectedPC = 1;
  String selectedDuration = "1 jam";
  List<String> availableDurations = ["1 jam", "3 jam", "5 jam", "10 jam"];

  // Pastikan FoodOrderController sudah diinisialisasi
  late final FoodOrderController _foodController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller jika belum ada
    if (!Get.isRegistered<FoodOrderController>()) {
      Get.put(FoodOrderController());
    }
    _foodController = FoodOrderController.to;
  }

  final Map<String, int> pcCounts = {
    'Reguler': 30,
    'VIP': 20,
    'VVIP': 15,
    'Battle Arena': 10,
  };

  final Map<String, int> pcPrices = {
    'Reguler': 5000,
    'VIP': 7000,
    'VVIP': 10000,
    'Battle Arena': 15000,
  };

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? true;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 10),
            Text(
              "Pilih Kategori PC",
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children:
                  pcCounts.keys.map((category) {
                    return ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected:
                          (_) => setState(() => selectedCategory = category),
                      selectedColor: Colors.blue,
                      labelStyle: TextStyle(
                        color:
                            selectedCategory == category
                                ? Colors.white
                                : textColor,
                      ),
                      backgroundColor: secondaryColor,
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              "Pilih Nomor PC",
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(pcCounts[selectedCategory]!, (index) {
                int pcNumber = index + 1;
                return GestureDetector(
                  onTap: () => setState(() => selectedPC = pcNumber),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color:
                          selectedPC == pcNumber ? Colors.blue : secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "$pcNumber",
                        style: TextStyle(
                          color:
                              selectedPC == pcNumber ? Colors.white : textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              "Durasi Waktu",
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children:
                  availableDurations.map((duration) {
                    return ChoiceChip(
                      label: Text(duration),
                      selected: selectedDuration == duration,
                      onSelected:
                          (_) => setState(() => selectedDuration = duration),
                      selectedColor: Colors.blue,
                      labelStyle: TextStyle(
                        color:
                            selectedDuration == duration
                                ? Colors.white
                                : textColor,
                      ),
                      backgroundColor: secondaryColor,
                    );
                  }).toList(),
            ),
            SizedBox(height: 30),
            Text(
              "Makanan & Minuman",
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => FoodBeveragePage(
                          isWhiteBackground: widget.isWhiteBackground,
                        ),
                  ),
                );
                // Refresh halaman setelah kembali dari FoodBeveragePage
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lihat Daftar Makanan & Minuman",
                      style: TextStyle(color: textColor),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: greyTextColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),

            // Menampilkan pesanan makanan yang dipilih
            Obx(() {
              final orderedItems = _foodController.orderedItems;
              if (orderedItems.isEmpty) return SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Pesanan Makanan & Minuman",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...orderedItems.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${item['name']} x${item['count']}",
                                  style: TextStyle(color: textColor),
                                ),
                                Text(
                                  "Rp ${(item['price'] as int) * (item['count'] as int)}",
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: greyTextColor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total F&B",
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Rp ${_foodController.totalFoodPrice}",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),

            SizedBox(height: 30),
            Text(
              "Riwayat Pemesanan",
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() {
                if (_foodController.bookingHistory.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Belum ada riwayat pemesanan",
                      style: TextStyle(color: greyTextColor),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      _foodController.bookingHistory.map((booking) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "${booking['category']} - PC ${booking['pc']} - ${booking['duration']}",
                            style: TextStyle(color: textColor),
                          ),
                        );
                      }).toList(),
                );
              }),
            ),
            SizedBox(height: 30),
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
                  final box = GetStorage();
                  int currentBalance = box.read('balance') ?? 0;

                  int pricePerHour = pcPrices[selectedCategory]!;
                  int hours = int.parse(selectedDuration.split(' ')[0]);
                  int pcTotal = pricePerHour * hours;
                  int foodTotal = _foodController.totalFoodPrice;
                  int grandTotal = pcTotal + foodTotal;

                  if (currentBalance < grandTotal) {
                    Get.snackbar(
                      'Saldo Tidak Cukup',
                      'Saldo kamu tidak mencukupi untuk booking ini. Silakan top-up terlebih dahulu.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  _showBookingConfirmation(textColor, greyTextColor);
                },

                child: Text(
                  "Konfirmasi Booking",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingConfirmation(Color textColor, Color greyTextColor) {
    int pricePerHour = pcPrices[selectedCategory]!;
    int hours = int.parse(selectedDuration.split(' ')[0]);
    int pcTotal = pricePerHour * hours;
    int foodTotal = _foodController.totalFoodPrice;
    int grandTotal = pcTotal + foodTotal;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              widget.isWhiteBackground ? Colors.white : Color(0xFF1F2937),
          title: Text("Konfirmasi Booking", style: TextStyle(color: textColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoRow("Kategori", selectedCategory, textColor, greyTextColor),
              _infoRow("PC", "$selectedPC", textColor, greyTextColor),
              _infoRow("Durasi", selectedDuration, textColor, greyTextColor),
              _infoRow("Biaya PC", "Rp $pcTotal", textColor, greyTextColor),

              // Tampilkan detail makanan jika ada
              if (_foodController.orderedItems.isNotEmpty) ...[
                Divider(color: greyTextColor, height: 24),
                Text(
                  "Pesanan Makanan & Minuman:",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ..._foodController.orderedItems.map(
                  (item) => _infoRow(
                    "${item['name']} x${item['count']}",
                    "Rp ${(item['price'] as int) * (item['count'] as int)}",
                    textColor,
                    greyTextColor,
                  ),
                ),
                _infoRow(
                  "Total F&B",
                  "Rp $foodTotal",
                  textColor,
                  greyTextColor,
                ),
              ],

              Divider(color: greyTextColor, height: 24),
              _infoRow(
                "TOTAL",
                "Rp $grandTotal",
                Colors.blue,
                textColor,
                isBold: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal", style: TextStyle(color: greyTextColor)),
            ),
            ElevatedButton(
              onPressed: () {
                final box = GetStorage();
                int currentBalance = box.read('balance') ?? 0;
                box.write(
                  'balance',
                  currentBalance - grandTotal,
                ); // ✅ kurangi saldo

                // Tambahkan booking ke riwayat
                _foodController.addBookingToHistory({
                  'category': selectedCategory,
                  'pc': selectedPC,
                  'duration': selectedDuration,
                  'pcTotal': pcTotal,
                  'foodTotal': foodTotal,
                  'grandTotal': grandTotal,
                  'date': DateTime.now().toString(),
                });

                Navigator.pop(context);

                _foodController.clearOrders();

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
              fontWeight: FontWeight.bold,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
