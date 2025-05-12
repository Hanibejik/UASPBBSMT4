import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'booking_page.dart'; // Import untuk FoodOrderController

class FoodBeveragePage extends StatefulWidget {
  final bool isWhiteBackground;

  const FoodBeveragePage({Key? key, required this.isWhiteBackground})
    : super(key: key);

  @override
  State<FoodBeveragePage> createState() => _FoodBeveragePageState();
}

class _FoodBeveragePageState extends State<FoodBeveragePage> {
  // Inisialisasi controller dari BookingPage
  final FoodOrderController _foodController = FoodOrderController.to;

  final List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Americano',
      'price': 15000,
      'category': 'Coffee',
      'image': 'assets/images/kopi/americano.jpg',
      'count': 0,
    },
    {
      'name': 'Cappucino',
      'price': 18000,
      'image': 'assets/images/kopi/cappucino.jpg',
      'category': 'Coffee',
      'count': 0,
    },
    {
      'name': 'Espresso',
      'price': 10000,
      'image': 'assets/images/kopi/espresso.jpg',
      'category': 'Coffee',
      'count': 0,
    },
    {
      'name': 'Caffe Latte',
      'price': 20000,
      'image': 'assets/images/kopi/cafelatte.jpg',
      'category': 'Coffee',
      'count': 0,
    },
    {
      'name': 'Caramel Latte',
      'price': 20000,
      'image': 'assets/images/kopi/caramelatte.jpg',
      'category': 'Coffee',
      'count': 0,
    },
    {
      'name': 'Kopi Susu Gula Aren',
      'price': 20000,
      'image': 'assets/images/kopisusu/kopisusuaren.jpg',
      'category': 'Coffee Milk',
      'count': 0,
    },
    {
      'name': 'Kopi Susu Cookies',
      'price': 12000,
      'image': 'assets/images/kopisusu/kopisusucookies.jpg',
      'category': 'Coffee Milk',
      'count': 0,
    },
    {
      'name': 'Kopi Susu Hazelnut',
      'price': 20000,
      'image': 'assets/images/kopisusu/kopisusuhazelnut.jpg',
      'category': 'Coffee Milk',
      'count': 0,
    },
    {
      'name': 'Kopi Susu Biscoff',
      'price': 24000,
      'image': 'assets/images/kopisusu/Picture16.jpg',
      'category': 'Coffee Milk',
      'count': 0,
    },
    {
      'name': 'Kopi Susu Regal',
      'price': 22000,
      'image': 'assets/images/kopisusu/Picture18.jpg',
      'category': 'Coffee Milk',
      'count': 0,
    },
    {
      'name': 'Matcha',
      'price': 20000,
      'image': 'assets/images/nonkopi/Picture20.jpg',
      'category': 'Non Coffee',
      'count': 0,
    },
    {
      'name': 'Red Velvet',
      'price': 18000,
      'image': 'assets/images/nonkopi/Picture23.jpg',
      'category': 'Non Coffee',
      'count': 0,
    },
    {
      'name': 'Dark Choco',
      'price': 18000,
      'image': 'assets/images/nonkopi/Picture25.jpg',
      'category': 'Non Coffee',
      'count': 0,
    },
    {
      'name': 'Choco Hazelnut',
      'price': 20000,
      'image': 'assets/images/nonkopi/Picture26.png',
      'category': 'Non Coffee',
      'count': 0,
    },
    {
      'name': 'Choco Mint',
      'price': 20000,
      'image': 'assets/images/nonkopi/Picture28.png',
      'category': 'Non Coffee',
      'count': 0,
    },
    {
      'name': 'Peach Tea',
      'price': 12000,
      'image': 'assets/images/nonkopi/Picture29.jpg',
      'category': 'Non Coffee',
      'count': 0,
    },
    {
      'name': 'Lyche Tea',
      'price': 14000,
      'image': 'assets/images/nonkopi/Picture30.jpg',
      'category': 'Non Coffee',
      'count': 0,
    },
    {
      'name': 'Lemon Tea',
      'price': 10000,
      'image': 'assets/images/nonkopi/Picture31.png',
      'category': 'Non Coffee',
      'count': 0,
    },
    {
      'name': 'Air Mineral',
      'price': 5000,
      'image': 'assets/images/nonkopi/Picture34.png',
      'category': 'Non Coffee',
      'count': 0,
    },
    {
      'name': 'Mix Platter',
      'price': 25000,
      'image': 'assets/images/snack/Picture35.jpg',
      'category': 'Snack',
      'count': 0,
    },
    {
      'name': 'French Fries',
      'price': 12000,
      'image': 'assets/images/snack/Picture36.jpg',
      'category': 'Snack',
      'count': 0,
    },
    {
      'name': 'Onion Ring',
      'price': 16000,
      'image': 'assets/images/snack/Picture37.jpg',
      'category': 'Snack',
      'count': 0,
    },
    {
      'name': 'Pisang Goreng',
      'price': 14000,
      'image': 'assets/images/snack/Picture38.png',
      'category': 'Snack',
      'count': 0,
    },
    {
      'name': 'Chicken Wings',
      'price': 20000,
      'image': 'assets/images/snack/Picture39.png',
      'category': 'Snack',
      'count': 0,
    },
    {
      'name': 'Nasi Ayam Sambal Matah',
      'price': 25000,
      'image': 'assets/images/maincourse/Picture42.png',
      'category': 'Main Course',
      'count': 0,
    },
    {
      'name': 'Nasi Chicken Katsu',
      'price': 23000,
      'image': 'assets/images/maincourse/Picture44.jpg',
      'category': 'Main Course',
      'count': 0,
    },
    {
      'name': 'Nasi Chicken Teriyaki',
      'price': 23000,
      'image': 'assets/images/maincourse/Picture45.jpg',
      'category': 'Main Course',
      'count': 0,
    },
    {
      'name': 'Nasi Goreng',
      'price': 28000,
      'image': 'assets/images/maincourse/Picture46.jpg',
      'category': 'Main Course',
      'count': 0,
    },
    {
      'name': 'Nasi Chicken Curry',
      'price': 25000,
      'image': 'assets/images/maincourse/Picture47.jpg',
      'category': 'Main Course',
      'count': 0,
    },
  ];

  String activeCategory = 'All';
  List<String> categories = [
    'All',
    'Coffee',
    'Coffee Milk',
    'Non Coffee',
    'Snack',
    'Main Course',
  ];

  @override
  void initState() {
    super.initState();
    // Pastikan FoodOrderController sudah diinisialisasi
    if (!Get.isRegistered<FoodOrderController>()) {
      Get.put(FoodOrderController());
    }

    // Muat pesanan yang ada (jika ada) ke foodItems
    _loadExistingOrders();
  }

  // Fungsi untuk memuat pesanan yang sudah ada sebelumnya
  void _loadExistingOrders() {
    for (var existingItem in _foodController.orderedItems) {
      for (var localItem in foodItems) {
        if (localItem['name'] == existingItem['name']) {
          setState(() {
            localItem['count'] = existingItem['count'];
          });
          break;
        }
      }
    }
  }

  List<Map<String, dynamic>> get filteredItems {
    if (activeCategory == 'All') return foodItems;
    return foodItems
        .where((item) => item['category'] == activeCategory)
        .toList();
  }

  int get totalPrice => foodItems.fold(
    0,
    (sum, item) => sum + (item['price'] as int) * (item['count'] as int),
  );

  int get totalItems =>
      foodItems.fold(0, (sum, item) => sum + (item['count'] as int));

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? true;

    Color backgroundColor =
        widget.isWhiteBackground
            ? Colors.white
            : (isDarkMode ? Colors.black : Colors.white);
    Color sectionColor =
        widget.isWhiteBackground
            ? Color(0xFFEEEEEE)
            : (isDarkMode ? Color(0xFF111827) : Colors.white);
    Color innerBoxColor =
        widget.isWhiteBackground
            ? Colors.white
            : (isDarkMode ? Color(0xFF1F2937) : Colors.grey.shade200);
    Color textColor =
        widget.isWhiteBackground
            ? Colors.black
            : (isDarkMode ? Colors.white : Colors.black);
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
            "Makanan & Minuman",
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
        iconTheme: IconThemeData(color: textColor),
        actions: [
          // Tambahkan tombol untuk kembali dan menyimpan
          TextButton(
            onPressed: () {
              // Simpan pesanan yang dipilih ke FoodOrderController
              _saveOrdersAndReturn();
            },
            child: Text(
              "Simpan",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:
                      () => setState(() => activeCategory = categories[index]),
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          activeCategory == categories[index]
                              ? Colors.blue
                              : sectionColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color:
                            activeCategory == categories[index]
                                ? Colors.white
                                : greyTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child:
                filteredItems.isEmpty
                    ? Center(
                      child: Text(
                        "Tidak ada item tersedia",
                        style: TextStyle(color: greyTextColor),
                      ),
                    )
                    : GridView.builder(
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: sectionColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    color: innerBoxColor,
                                  ),
                                  width: double.infinity,
                                  child:
                                      item.containsKey('image') &&
                                              item['image'] != null
                                          ? ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                            ),
                                            child: Image.asset(
                                              item['image'],
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                          : Icon(
                                            item['category'] == 'Food'
                                                ? Icons.fastfood
                                                : Icons.local_drink,
                                            color: Colors.blue,
                                            size: 60,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Rp ${item['price']}',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        item['count'] > 0
                                            ? Row(
                                              children: [
                                                _buildCircleButton(
                                                  icon: Icons.remove,
                                                  onPressed:
                                                      () => setState(
                                                        () => item['count']--,
                                                      ),
                                                ),
                                                SizedBox(width: 12),
                                                Text(
                                                  '${item['count']}',
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 12),
                                                _buildCircleButton(
                                                  icon: Icons.add,
                                                  onPressed:
                                                      () => setState(
                                                        () => item['count']++,
                                                      ),
                                                ),
                                              ],
                                            )
                                            : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(30, 30),
                                                padding: EdgeInsets.zero,
                                              ),
                                              onPressed:
                                                  () => setState(
                                                    () => item['count'] = 1,
                                                  ),
                                              child: Icon(Icons.add, size: 16),
                                            ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
          if (totalItems > 0)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: sectionColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$totalItems item',
                        style: TextStyle(color: greyTextColor),
                      ),
                      Text(
                        'Rp $totalPrice',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Simpan ke FoodOrderController dan kembali ke halaman booking
                      _saveOrdersAndReturn();

                      // Tampilkan pesan sukses
                      Get.snackbar(
                        'Pesanan Ditambahkan',
                        'Pesanan telah ditambahkan ke booking Anda',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                    child: Text(
                      'Tambahkan ke Booking',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Fungsi untuk menyimpan pesanan dan kembali ke halaman booking
  void _saveOrdersAndReturn() {
    // Filter hanya item yang jumlahnya > 0
    final List<Map<String, dynamic>> selectedItems =
        foodItems.where((item) => item['count'] > 0).toList();

    // Simpan ke FoodOrderController
    _foodController.addOrderedItems(selectedItems);

    // Kembali ke halaman booking
    Navigator.pop(context);
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
