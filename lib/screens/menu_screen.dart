// menu_screen.dart
import 'package:flutter/material.dart';
import 'game_screen.dart';
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

  final SoundManager _soundManager = SoundManager();

  @override
  void initState() {
    super.initState();
    _soundManager.loadSoundsFromJson(); // Charger les sons au démarrage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showDifficultySelection(context);
              },
              child: Text(_selectedDifficulty),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      final gameController = GameController(_soundManager);
                      gameController.setMode(_selectedMode);
                      gameController.setDifficulty(_selectedDifficulty);
                      return GameScreen(gameController: gameController);
                    },
                  ),
                );
              },
              child: Text('Commencer une Partie'),
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
          title: Text('Sélectionnez un Mode de Jeu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Découverte'),
                onTap: () {
                  setState(() {
                    _selectedMode = 'Découverte';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Cri des Animaux'),
                onTap: () {
                  setState(() {
                    _selectedMode = 'Cri des Animaux';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Bruits Familiers'),
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
          title: Text('Sélectionnez une Difficulté'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Facile'),
                onTap: () {
                  setState(() {
                    _selectedDifficulty = 'Facile';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Rapide'),
                onTap: () {
                  setState(() {
                    _selectedDifficulty = 'Rapide';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Très Rapide'),
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
