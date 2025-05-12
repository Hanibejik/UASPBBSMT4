import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class GameServicePage extends StatelessWidget {
  final bool isWhiteBackground;

  const GameServicePage({Key? key, required this.isWhiteBackground})
    : super(key: key);

  final List<Map<String, String>> games = const [
    {'name': 'Ayodance', 'image': 'assets/images/game/ayodance.jpg'},
    {'name': 'Counter Strike 2', 'image': 'assets/images/game/cs.jpg'},
    {'name': 'Dota 2', 'image': 'assets/images/game/dota.jpg'},
    {'name': 'Epic Game', 'image': 'assets/images/game/epicgame.jpg'},
    {'name': 'Steam', 'image': 'assets/images/game/steam.jpg'},
    {'name': 'Lost Saga Origin', 'image': 'assets/images/game/ls.jpg'},
    {'name': 'Pointblank', 'image': 'assets/images/game/pb.jpg'},
    {'name': 'Roblox', 'image': 'assets/images/game/roblox.jpg'},
    {'name': 'Valorant', 'image': 'assets/images/game/valo.jpg'},
    {'name': 'Fortnite', 'image': 'assets/images/game/fn.jpg'},
    {'name': 'Tambah Game'}, // menu tambahan
  ];

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? true;

    Color backgroundColor =
        isWhiteBackground
            ? Colors.white
            : (isDarkMode ? Colors.black : Colors.white);
    Color cardColor =
        isWhiteBackground
            ? Colors.white
            : (isDarkMode ? const Color(0xFF1F2937) : Colors.grey.shade200);
    Color textColor =
        isWhiteBackground
            ? Colors.black
            : (isDarkMode ? Colors.white : Colors.black);
    Color greyTextColor =
        isWhiteBackground ? Colors.grey.shade700 : Colors.grey;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text("Layanan Game", style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: games.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final game = games[index];
            final isTambahGame = game['name'] == 'Tambah Game';

            return GestureDetector(
              onTap: () {
                if (isTambahGame) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Silakan ke operator warnet untuk menginstall game Anda.",
                      ),
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child:
                            isTambahGame
                                ? Container(
                                  color: Colors.blue.withOpacity(0.1),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      size: 48,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                                : Image.asset(
                                  game['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder:
                                      (_, __, ___) => Center(
                                        child: Icon(
                                          Icons.videogame_asset,
                                          size: 48,
                                          color: greyTextColor,
                                        ),
                                      ),
                                ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        game['name']!,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
