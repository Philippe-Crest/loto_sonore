import 'package:flutter/material.dart';
import '../models/game_settings.dart';
import '../services/game_controller.dart';

class GameScreen extends StatelessWidget {
  final GameSettings gameSettings;
  final GameController gameController;

  const GameScreen({
    super.key,
    required this.gameSettings,
    required this.gameController,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('Mode reçu dans GameScreen : ${gameSettings.mode}');
    debugPrint('Difficulté reçue dans GameScreen : ${gameSettings.difficulty}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu en cours'),
      ),
      body: Center(
        child: SizedBox.expand( // Agrandit la zone de positionnement
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Bouton Jaune (en bas à gauche)
              Positioned(
                bottom: 150,
                left: 80,
                child: ElevatedButton(
                  onPressed: () {
                    gameController.selectColor('jaune');
                    gameSettings.selectedColors.add('jaune');
                    debugPrint('Couleur ajoutée : jaune');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: const CircleBorder(),
                    fixedSize: const Size(100, 100), // Taille fixe pour un bouton circulaire
                  ),
                  child: null,
                ),
              ),
              // Bouton Vert (en haut à droite)
              Positioned(
                top: 150,
                right: 80,
                child: ElevatedButton(
                  onPressed: () {
                    gameController.selectColor('vert');
                    gameSettings.selectedColors.add('vert');
                    debugPrint('Couleur ajoutée : vert');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const CircleBorder(),
                    fixedSize: const Size(100, 100),
                  ),
                  child: null,
                ),
              ),
              // Bouton Rouge (en haut à gauche)
              Positioned(
                top: 150,
                left: 80,
                child: ElevatedButton(
                  onPressed: () {
                    gameController.selectColor('rouge');
                    gameSettings.selectedColors.add('rouge');
                    debugPrint('Couleur ajoutée : rouge');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const CircleBorder(),
                    fixedSize: const Size(100, 100),
                  ),
                  child: null,
                ),
              ),
              // Bouton Bleu (en bas à droite)
              Positioned(
                bottom: 150,
                right: 80,
                child: ElevatedButton(
                  onPressed: () {
                    gameController.selectColor('bleu');
                    gameSettings.selectedColors.add('bleu');
                    debugPrint('Couleur ajoutée : bleu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const CircleBorder(),
                    fixedSize: const Size(100, 100),
                  ),
                  child: null,
                ),
              ),
              // Bouton Orange (central)
              ElevatedButton(
                onPressed: () {
                  gameController.startGame();
                  debugPrint('Lancement du jeu avec les paramètres suivants :');
                  debugPrint('Mode : ${gameSettings.mode}');
                  debugPrint('Difficulté : ${gameSettings.difficulty}');
                  debugPrint('Couleurs sélectionnées : ${gameSettings.selectedColors.join(', ')}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: const CircleBorder(),
                  fixedSize: const Size(140, 140), // Plus grand que les autres boutons
                ),
                child: const Text(
                  'Lancer',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
