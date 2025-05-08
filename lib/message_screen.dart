import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const MessageScreen({Key? key, required this.onToggleTheme})
    : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List<Map<String, dynamic>> pesan = [
    {
      'nama': 'Bagus',
      'pesan': 'Pye cok kwe neng di?',
      'waktu': '10:30',
      'belumDibaca': 2,
      'avatar': 'B',
    },
    {
      'nama': 'Dewi',
      'pesan': 'Aku pengen pedot yang!',
      'waktu': '09:15',
      'belumDibaca': 0,
      'avatar': 'D',
    },
    {
      'nama': 'Andri',
      'pesan': 'Info sparing clan',
      'waktu': 'Kemarin',
      'belumDibaca': 0,
      'avatar': 'A',
    },
    {
      'nama': 'Putri',
      'pesan': 'Mas, saya dari bank BRI, ini masnya nunggak yaaa',
      'waktu': 'Kemarin',
      'belumDibaca': 3,
      'avatar': 'P',
    },
    {
      'nama': 'Rudi',
      'pesan': 'OTW GEDE',
      'waktu': '22/04',
      'belumDibaca': 0,
      'avatar': 'R',
    },
    {
      'nama': 'Sinta',
      'pesan': 'Ayo yang neng Jogja',
      'waktu': '20/04',
      'belumDibaca': 0,
      'avatar': 'S',
    },
    {
      'nama': 'Budi',
      'pesan': 'Asle yangmu to ?',
      'waktu': '19/04',
      'belumDibaca': 1,
      'avatar': 'B',
    },
    {
      'nama': 'Rina',
      'pesan': 'Login bang',
      'waktu': '18/04',
      'belumDibaca': 0,
      'avatar': 'R',
    },
    {
      'nama': 'Dimas',
      'pesan': 'Sido valo ora?',
      'waktu': '15/04',
      'belumDibaca': 0,
      'avatar': 'D',
    },
    {
      'nama': 'Lia',
      'pesan': 'Mas, jadi?',
      'waktu': '12/04',
      'belumDibaca': 0,
      'avatar': 'L',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari pesan...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[200],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: pesan.length,
              itemBuilder: (context, index) {
                final pesanItem = pesan[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      pesanItem['avatar'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    pesanItem['nama'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    pesanItem['pesan'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        pesanItem['waktu'],
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      if (pesanItem['belumDibaca'] > 0)
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            pesanItem['belumDibaca'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Pesan dari ${pesanItem['nama']}'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Buat pesan baru'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: Icon(Icons.chat),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
