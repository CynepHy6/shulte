enum GameState { start, end, repeat }

enum GameMode {
  debug,
  x3,
  x4,
  x5,
  x6;

  static fromString(String mode) {
    switch (mode) {
      case 'GameMode.debug':
        return GameMode.debug;
      case 'GameMode.x3':
        return GameMode.x3;
      case 'GameMode.x4':
        return GameMode.x4;
      case 'GameMode.x5':
        return GameMode.x5;
      case 'GameMode.x6':
        return GameMode.x6;
    }
  }
}
