// sounds_manager.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';

class Sound {
  final String id; // ID unique : ex. "1_vert_cri"
  final String fileName; // Nom du fichier : ex. "ane.mp3"
  final String color; // Couleur associée : ex. "vert"
  final String category; // Catégorie : ex. "cri"
  final int number; // Numéro unique dans cette catégorie et couleur

  Sound({
    required this.id,
    required this.fileName,
    required this.color,
    required this.category,
    required this.number,
  });

  factory Sound.fromJson(Map<String, dynamic> json) {
    return Sound(
      id: json['id'],
      fileName: json['fileName'],
      color: json['color'],
      category: json['category'],
      number: json['number'],
    );
  }
}

class SoundManager {
  // Liste des sons
  final List<Sound> sounds = [];
  final Set<String> playedSounds = {}; // Garde une trace des sons déjà joués

  // Charge les sons à partir d'un fichier JSON
  Future<void> loadSoundsFromJson() async {
    try {
      final jsonString = await rootBundle.loadString('assets/sounds_data.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      sounds.clear();
      sounds.addAll(jsonData.map((data) => Sound.fromJson(data)));
      debugPrint('Tous les sons ont été chargés à partir du JSON.');
    } catch (e) {
      debugPrint('Erreur lors du chargement du fichier JSON : $e');
    }
  }

  // Joue un son aléatoire pour une catégorie et une couleur, en évitant les répétitions
  String? playRandomSound(String category, String color) {
    debugPrint("Lecture d'un son aléatoire dans la catégorie '$category' et la couleur '$color'");
    final filteredSounds = sounds.where((sound) =>
        sound.category == category && sound.color == color && !playedSounds.contains(sound.id)).toList();

    if (filteredSounds.isNotEmpty) {
      final randomSound = filteredSounds[Random().nextInt(filteredSounds.length)];
      playedSounds.add(randomSound.id);
      playSound(randomSound.fileName);
      return randomSound.id;
    } else {
      debugPrint("Tous les sons de la catégorie '$category' et de la couleur '$color' ont été joués.");
      return null; // Indique que tous les sons ont été joués
    }
  }

  // Vérifie si tous les sons d'une catégorie et d'une couleur ont été joués
  bool allSoundsPlayed(String category, String color) {
  final totalSounds = sounds.where((sound) => sound.category == category && sound.color == color).length;
  final playedSoundsCount = playedSounds.where((id) =>
      sounds.any((sound) => sound.id == id && sound.category == category && sound.color == color)).length;
  return playedSoundsCount >= totalSounds;
}

  // Joue un son pour le choix d'une couleur
  void playChoiceSound() {
    debugPrint("Lecture du son de choix pour signaler la sélection d'une couleur.");
    playSound('choix.mp3');
    debugPrint("Son de choix joué.");
  }

  // Joue les sons selon les règles du mode Découverte
Future<void> playDiscoveryModeSounds() async {
  final unplayedSounds = sounds.where((sound) => !playedSounds.contains(sound.id)).toList();
  if (unplayedSounds.isNotEmpty) {
    for (var sound in unplayedSounds) {
      playSound(sound.fileName);
      playedSounds.add(sound.id);
      debugPrint("Son joué en mode Découverte : ${sound.fileName}");
      await Future.delayed(Duration(seconds: 2)); // Délai fixe de 2 secondes entre les sons
    }
    // Une fois tous les sons joués, recommence depuis le début
    playedSounds.clear();
    debugPrint("Reprise de la boucle en mode Découverte.");
    await playDiscoveryModeSounds();
  } else {
    debugPrint("Tous les sons en mode Découverte ont été joués.");
  }
}

  // Joue les sons selon les règles des modes Rapide et Très Rapide
  Future<void> playTimedModeSounds(String category, int delayInSeconds, String color) async {
  final filteredSounds = sounds.where((sound) =>
      sound.category == category && sound.color == color && !playedSounds.contains(sound.id)).toList();

  for (var sound in filteredSounds) {
    playSound(sound.fileName);
    playedSounds.add(sound.id);
    debugPrint("Son joué pour la couleur $color : ${sound.fileName}");
    await Future.delayed(Duration(seconds: delayInSeconds));
  }

  debugPrint("Tous les sons de la couleur $color ont été joués.");
}
  // Joue un son en cas de victoire
  void playVictorySound() {
    debugPrint("Lecture du son de victoire.");
    playSound('victoire.mp3');
    debugPrint("Son de victoire joué.");
  }

  // Joue un son en cas de défaite
  void playDefeatSound() {
    debugPrint("Lecture du son de défaite.");
    playSound('defaite.mp3');
    debugPrint("Son de défaite joué.");
  }

  // Charge tous les fichiers audio (précache les sons si nécessaire)
  Future<void> loadAllSounds() async {
    for (var sound in sounds) {
      try {
        await rootBundle.load('assets/sounds/${sound.fileName}');
        debugPrint('Fichier chargé : ${sound.fileName}');
      } catch (e) {
        debugPrint('Erreur lors du chargement de ${sound.fileName} : $e');
      }
    }
  }

  // Récupère un son par son ID
  Sound? getSoundById(String id) {
    return sounds.firstWhere((sound) => sound.id == id, orElse: () => Sound(id: '', fileName: '', color: '', category: '', number: 0));
  }

  // Récupère les sons par catégorie
  List<Sound> getSoundsByCategory(String category) {
    return sounds.where((sound) => sound.category == category).toList();
  }

  // Récupère les sons par couleur
  List<Sound> getSoundsByColor(String color) {
    return sounds.where((sound) => sound.color == color).toList();
  }

  // Joue un son spécifique
  void playSound(String fileName) {
    debugPrint("Tentative de lecture du son : $fileName");
    // Utilisation de la bibliothèque audioplayers pour jouer le son
    final player = AudioPlayer();
    player.play(AssetSource('sounds/$fileName'));
  }

  // Joue un son par son ID
  void playSoundById(String id) {
    final sound = getSoundById(id);
    if (sound != null) {
      playSound(sound.fileName);
    } else {
      debugPrint("Son introuvable pour l'ID : $id");
    }
  }
}
