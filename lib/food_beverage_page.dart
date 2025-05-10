import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodBeveragePage extends StatefulWidget {
  const FoodBeveragePage({Key? key}) : super(key: key);

  @override
  State<FoodBeveragePage> createState() => _FoodBeveragePageState();
}

class _FoodBeveragePageState extends State<FoodBeveragePage> {
  final List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Chicken Wings',
      'price': 25000,
      'image': 'chicken_wings.jpg',
      'category': 'Food',
      'count': 0,
    },
    {
      'name': 'French Fries',
      'price': 15000,
      'image': 'french_fries.jpg',
      'category': 'Food',
      'count': 0,
    },
    {
      'name': 'Burger',
      'price': 30000,
      'image': 'burger.jpg',
      'category': 'Food',
      'count': 0,
    },
    {
      'name': 'Pizza',
      'price': 45000,
      'image': 'pizza.jpg',
      'category': 'Food',
      'count': 0,
    },
    {
      'name': 'Ice Coffee',
      'price': 18000,
      'image': 'ice_coffee.jpg',
      'category': 'Beverage',
      'count': 0,
    },
    {
      'name': 'Cola',
      'price': 10000,
      'image': 'cola.jpg',
      'category': 'Beverage',
      'count': 0,
    },
    {
      'name': 'Mineral Water',
      'price': 5000,
      'image': 'water.jpg',
      'category': 'Beverage',
      'count': 0,
    },
    {
      'name': 'Tea',
      'price': 8000,
      'image': 'tea.jpg',
      'category': 'Beverage',
      'count': 0,
    },
  ];

  String activeCategory = 'All';
  List<String> categories = ['All', 'Food', 'Beverage'];

  List<Map<String, dynamic>> get filteredItems {
    if (activeCategory == 'All') {
      return foodItems;
    }
    return foodItems
        .where((item) => item['category'] == activeCategory)
        .toList();
  }

  int get totalPrice {
    return foodItems.fold<int>(
      0,
      (sum, item) => sum + (item['price'] as int) * (item['count'] as int),
    );
  }

  int get totalItems {
    return foodItems.fold<int>(0, (sum, item) => sum + (item['count'] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Makanan & Minuman",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Text("4G", style: TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Tabs
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      activeCategory = categories[index];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          activeCategory == categories[index]
                              ? Colors.blue
                              : Color(0xFF111827),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color:
                            activeCategory == categories[index]
                                ? Colors.white
                                : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Food & Beverage List
          Expanded(
            child:
                filteredItems.isEmpty
                    ? Center(
                      child: Text(
                        "Tidak ada item tersedia",
                        style: TextStyle(color: Colors.grey),
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
                            color: Color(0xFF111827),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image Container
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    color: Color(0xFF1F2937),
                                  ),
                                  width: double.infinity,
                                  child: Icon(
                                    item['category'] == 'Food'
                                        ? Icons.fastfood
                                        : Icons.local_drink,
                                    color: Colors.blue,
                                    size: 60,
                                  ),
                                ),
                              ),

                              // Item Details
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: TextStyle(
                                        color: Colors.white,
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

                                    // Add/Remove item controls
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        item['count'] > 0
                                            ? Row(
                                              children: [
                                                _buildCircleButton(
                                                  icon: Icons.remove,
                                                  onPressed: () {
                                                    setState(() {
                                                      if (item['count'] > 0) {
                                                        item['count']--;
                                                      }
                                                    });
                                                  },
                                                ),
                                                SizedBox(width: 12),
                                                Text(
                                                  '${item['count']}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 12),
                                                _buildCircleButton(
                                                  icon: Icons.add,
                                                  onPressed: () {
                                                    setState(() {
                                                      item['count']++;
                                                    });
                                                  },
                                                ),
                                              ],
                                            )
                                            : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(30, 30),
                                                padding: EdgeInsets.zero,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  item['count'] = 1;
                                                });
                                              },
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

          // Cart Summary
          if (totalItems > 0)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF111827),
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
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'Rp $totalPrice',
                        style: TextStyle(
                          color: Colors.white,
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
                      Get.snackbar(
                        'Pesanan Berhasil',
                        'Pesanan Anda sedang diproses',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );

                      // Reset counts after order is placed
                      setState(() {
                        for (var item in foodItems) {
                          item['count'] = 0;
                        }
                      });
                    },
                    child: Text(
                      'Pesan Sekarang',
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
