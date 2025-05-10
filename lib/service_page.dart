import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  // Tambahkan parameter isWhiteBackground
  final bool isWhiteBackground;

  const ServicesPage({Key? key, this.isWhiteBackground = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gunakan background berdasarkan properti isWhiteBackground
      backgroundColor: isWhiteBackground ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Halaman Layanan",
            style: TextStyle(
              // Sesuaikan warna teks berdasarkan background
              color: isWhiteBackground ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Services Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // Sesuaikan warna background card berdasarkan tema
                  color: isWhiteBackground ? Colors.white : Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                  // Tambahkan shadow untuk background putih
                  boxShadow:
                      isWhiteBackground
                          ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ]
                          : [],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Layanan",
                      style: TextStyle(
                        color: isWhiteBackground ? Colors.black : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        ServiceTile(
                          icon: Icons.print,
                          title: "Print",
                          isActive: true,
                          isWhiteBackground: isWhiteBackground,
                        ),
                        ServiceTile(
                          icon: Icons.account_balance_wallet,
                          title: "Top-Up",
                          isActive: true,
                          isWhiteBackground: isWhiteBackground,
                        ),
                        ServiceTile(
                          icon: Icons.scanner,
                          title: "Scan",
                          isActive: true,
                          isWhiteBackground: isWhiteBackground,
                        ),
                        ServiceTile(
                          icon: Icons.fastfood,
                          title: "Food",
                          isActive: false,
                          isWhiteBackground: isWhiteBackground,
                        ),
                        ServiceTile(
                          icon: Icons.wifi,
                          title: "WiFi",
                          isActive: true,
                          isWhiteBackground: isWhiteBackground,
                        ),
                        ServiceTile(
                          icon: Icons.more_horiz,
                          title: "Lainnya",
                          isActive: false,
                          isWhiteBackground: isWhiteBackground,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Recent Services
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isWhiteBackground ? Colors.white : Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow:
                      isWhiteBackground
                          ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ]
                          : [],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Layanan Terakhir",
                      style: TextStyle(
                        color: isWhiteBackground ? Colors.black : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    RecentServiceItem(
                      icon: Icons.print,
                      title: "Print Dokumen",
                      subtitle: "10 halaman",
                      date: "Hari ini, 12:30",
                      amount: "Rp 5.000",
                      isWhiteBackground: isWhiteBackground,
                    ),
                    Divider(
                      color:
                          isWhiteBackground
                              ? Colors.grey.shade300
                              : Colors.grey.shade800,
                    ),
                    RecentServiceItem(
                      icon: Icons.wifi,
                      title: "Paket WiFi",
                      subtitle: "3 jam",
                      date: "Hari ini, 10:15",
                      amount: "Rp 15.000",
                      isWhiteBackground: isWhiteBackground,
                    ),
                    Divider(
                      color:
                          isWhiteBackground
                              ? Colors.grey.shade300
                              : Colors.grey.shade800,
                    ),
                    RecentServiceItem(
                      icon: Icons.account_balance_wallet,
                      title: "Top Up Saldo",
                      subtitle: "Via DANA",
                      date: "Kemarin, 16:45",
                      amount: "Rp 50.000",
                      isWhiteBackground: isWhiteBackground,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Popular Services
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isWhiteBackground ? Colors.white : Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow:
                      isWhiteBackground
                          ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ]
                          : [],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Layanan Populer",
                      style: TextStyle(
                        color: isWhiteBackground ? Colors.black : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        PopularServiceButton(
                          icon: Icons.computer,
                          label: "Booking PC",
                          isWhiteBackground: isWhiteBackground,
                        ),
                        SizedBox(width: 15),
                        PopularServiceButton(
                          icon: Icons.print,
                          label: "Print Dokumen",
                          isWhiteBackground: isWhiteBackground,
                        ),
                      ],
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
}

class ServiceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final bool isWhiteBackground;

  const ServiceTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.isActive,
    this.isWhiteBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isWhiteBackground ? Colors.grey.shade100 : Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isActive ? Colors.blue : Colors.grey.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(icon, color: Colors.white, size: 24)),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: isWhiteBackground ? Colors.black : Colors.white,
              fontSize: 14,
            ),
          ),
          if (isActive)
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

class RecentServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String date;
  final String amount;
  final bool isWhiteBackground;

  const RecentServiceItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    this.isWhiteBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(icon, color: Colors.blue, size: 20)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isWhiteBackground ? Colors.black : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: isWhiteBackground ? Colors.black : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(date, style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class PopularServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isWhiteBackground;

  const PopularServiceButton({
    Key? key,
    required this.icon,
    required this.label,
    this.isWhiteBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isWhiteBackground ? Colors.grey.shade100 : Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isWhiteBackground ? Colors.black : Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
