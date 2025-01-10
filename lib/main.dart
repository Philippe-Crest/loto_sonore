// main.dart
import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';
import 'screens/game_screen.dart';
import 'services/game_controller.dart';
import 'services/sound_manager.dart';
import 'models/game_settings.dart';

class LotoSonoreApp extends StatelessWidget {
  const LotoSonoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    final soundManager = SoundManager();
    final gameController = GameController(soundManager);

    final gameSettings = GameSettings(
      mode: 'Découverte', // Mode par défaut
      difficulty: 'Facile', // Difficulté par défaut
      selectedColors: {}, // Les couleurs seront ajoutées dans game_screen.dart
    );

    return MaterialApp(
      title: 'Loto Sonore',
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(), // Menu principal
        '/game': (context) => GameScreen(
          gameController: gameController,
          gameSettings: gameSettings, // Ajout du paramètre requis
        ),
      },
    );
  }
}

void main() {
  runApp(const LotoSonoreApp());
}
