// main.dart
import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';
import 'screens/game_screen.dart';
import 'services/game_controller.dart';
import 'services/sound_manager.dart';

class LotoSonoreApp extends StatelessWidget {
  const LotoSonoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    final soundManager = SoundManager();
    final gameController = GameController(soundManager);

    return MaterialApp(
      title: 'Loto Sonore',
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(), // Menu principal
        '/game': (context) => GameScreen(gameController: gameController), // Écran de jeu
      },
    );
  }
}

void main() {
  runApp(const LotoSonoreApp());
}
