// game_controller.dart
import 'package:flutter/material.dart';
import 'sound_manager.dart';

class GameController {
  final SoundManager soundManager;
  final Set<String> selectedColors = {}; // Garde une trace des couleurs sélectionnées par les joueurs
  String mode = 'Découverte'; // Mode par défaut : Découverte
  String difficulty = 'Facile'; // Difficulté par défaut

  GameController(this.soundManager);

  // Gestion du choix d'une couleur
  void selectColor(String color) {
    if (!selectedColors.contains(color)) {
      selectedColors.add(color);
      soundManager.playChoiceSound();
      debugPrint("Couleur sélectionnée : $color");
    } else {
      debugPrint("Couleur déjà sélectionnée : $color");
    }
  }

  // Définir le mode de jeu
  void setMode(String newMode) {
    mode = newMode;
    debugPrint("Mode de jeu défini sur : $mode");
  }

  // Définir la difficulté
  void setDifficulty(String newDifficulty) {
    difficulty = newDifficulty;
    debugPrint("Difficulté définie sur : $difficulty");
  }

  // Lancement du jeu
  Future<void> startGame() async {
    debugPrint("Lancement du jeu en mode $mode, difficulté $difficulty avec les couleurs : $selectedColors");

    if (mode == 'Découverte') {
      await soundManager.playDiscoveryModeSounds();
    } else {
      int delayInSeconds;
      if (difficulty == 'Facile') {
        delayInSeconds = 6;
      } else if (difficulty == 'Rapide') {
        delayInSeconds = 4;
      } else {
        delayInSeconds = 2;
      }

      for (var color in selectedColors) {
        final category = mode == 'Cri des Animaux' ? 'cri' : 'bruit';
        await soundManager.playTimedModeSounds(category, delayInSeconds, color);
        debugPrint("Traitement de la couleur : \$color");
      }
    }
  }

  // Gestion d'une déclaration de victoire
  void handleVictoryAttempt(String color) {
    final allPlayed = soundManager.allSoundsPlayed('cri', color);
    if (allPlayed) {
      soundManager.playVictorySound();
      debugPrint("Victoire pour la couleur : $color");
    } else {
      soundManager.playDefeatSound();
      debugPrint("Défaite pour la couleur : $color");
    }
  }
}
