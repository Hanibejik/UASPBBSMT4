import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // Tambahkan parameter isWhiteBackground
  final bool isWhiteBackground;

  const HomePage({Key? key, this.isWhiteBackground = false}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Gunakan background berdasarkan properti isWhiteBackground
    return Scaffold(
      backgroundColor: widget.isWhiteBackground ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Halaman Beranda",
            style: TextStyle(
              // Sesuaikan warna teks berdasarkan background
              color: widget.isWhiteBackground ? Colors.black : Colors.white,
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
              // Cafe Solution Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // Sesuaikan warna background card berdasarkan tema
                  color:
                      widget.isWhiteBackground
                          ? Colors.white
                          : Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                  // Tambahkan shadow untuk background putih
                  boxShadow:
                      widget.isWhiteBackground
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cafe Solution",
                          style: TextStyle(
                            color:
                                widget.isWhiteBackground
                                    ? Colors.black
                                    : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Sisa PC Tidak Aktif",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "12",
                      style: TextStyle(
                        color:
                            widget.isWhiteBackground
                                ? Colors.black
                                : Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Promosi",
                      style: TextStyle(
                        color:
                            widget.isWhiteBackground
                                ? Colors.black
                                : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  widget.isWhiteBackground
                                      ? Colors.grey.shade100
                                      : Color(0xFF1F2937),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discount Up",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "50%",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  widget.isWhiteBackground
                                      ? Colors.grey.shade100
                                      : Color(0xFF1F2937),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Weekend",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Special",
                                  style: TextStyle(
                                    color:
                                        widget.isWhiteBackground
                                            ? Colors.black
                                            : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Offer",
                                  style: TextStyle(
                                    color:
                                        widget.isWhiteBackground
                                            ? Colors.black
                                            : Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Promost",
                      style: TextStyle(
                        color:
                            widget.isWhiteBackground
                                ? Colors.black
                                : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        ServiceButton(
                          icon: Icons.print,
                          label: "Print",
                          color: Colors.blue,
                          isWhiteBackground: widget.isWhiteBackground,
                        ),
                        SizedBox(width: 15),
                        ServiceButton(
                          icon: Icons.attach_money,
                          label: "Top-Up",
                          color: Colors.blue,
                          isWhiteBackground: widget.isWhiteBackground,
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

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isWhiteBackground;

  const ServiceButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    this.isWhiteBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  isWhiteBackground ? Colors.grey.shade100 : Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
