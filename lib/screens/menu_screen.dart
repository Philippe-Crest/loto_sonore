// menu_screen.dart
import 'package:flutter/material.dart';
import 'game_screen.dart';
import '../models/game_settings.dart';
import '../services/game_controller.dart';
import '../services/sound_manager.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  String _selectedMode = 'Choisir le Mode de Jeu';
  String _selectedDifficulty = 'Choisir une Difficulté';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showModeSelection(context);
              },
              child: Text(_selectedMode),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showDifficultySelection(context);
              },
              child: Text(_selectedDifficulty),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final soundManager = SoundManager();
                final gameController = GameController(soundManager);

                final gameSettings = GameSettings(
                  mode: _selectedMode,
                  difficulty: _selectedDifficulty,
                  selectedColors: {}, // Les couleurs seront définies dans game_screen.dart
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      gameSettings: gameSettings,
                      gameController: gameController,
                    ),
                  ),
                );
              },
              child: const Text('Commencer une Partie'),
            ),
          ],
        ),
      ),
    );
  }

  void _showModeSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sélectionnez un Mode de Jeu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Découverte'),
                onTap: () {
                  setState(() {
                    _selectedMode = 'Découverte';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Cri des Animaux'),
                onTap: () {
                  setState(() {
                    _selectedMode = 'Cri des Animaux';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Bruits Familiers'),
                onTap: () {
                  setState(() {
                    _selectedMode = 'Bruits Familiers';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDifficultySelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sélectionnez une Difficulté'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Facile'),
                onTap: () {
                  setState(() {
                    _selectedDifficulty = 'Facile';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Rapide'),
                onTap: () {
                  setState(() {
                    _selectedDifficulty = 'Rapide';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Très Rapide'),
                onTap: () {
                  setState(() {
                    _selectedDifficulty = 'Très Rapide';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
