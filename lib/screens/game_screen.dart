import 'package:flutter/material.dart';
import 'package:loto_sonore/services/game_controller.dart';

class GameScreen extends StatelessWidget {
  final GameController gameController;

  const GameScreen({super.key, required this.gameController});

  @override
  Widget build(BuildContext context) {
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
