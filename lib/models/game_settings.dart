// game_settings.dart
class GameSettings {
  final String mode; // Découverte, Cri des Animaux, Bruits Familiers
  final String difficulty; // Facile, Rapide, Très Rapide
  final Set<String> selectedColors; // Couleurs choisies

  GameSettings({
    required this.mode,
    required this.difficulty,
    required this.selectedColors,
  });

  @override
  String toString() {
    return 'GameSettings(mode: $mode, difficulty: $difficulty, selectedColors: $selectedColors)';
  }
}
