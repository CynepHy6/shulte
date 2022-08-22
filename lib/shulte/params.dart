import 'package:flutter/material.dart';
import 'repositories/in_memory_cache.dart';
import 'repositories/repository.dart';
import 'configs/enums.dart';
import 'configs/field_size.dart';

class Params {
  final GameMode mode;
  final double blockWidth;
  final double blockHeight;
  final double blockMargin;
  double? fieldWidth;
  double? fieldHeight;
  List<int> indexes = [];
  Color color;
  late Color background;
  late double blockFontSize;
  late int nextNum;
  late GameState state;
  late Stopwatch stopwatch;
  Repository repository = InMemoryCache();

  Params({
    required this.mode,
    this.blockWidth = 60,
    this.blockHeight = 60,
    this.blockMargin = 1,
    this.color = Colors.black,
    Color? background,
    double? blockFontSize,
  }) {
    this.blockFontSize = blockFontSize ?? 2 * blockWidth / 4;
    this.background = background ?? Colors.grey.shade200;
    stopwatch = Stopwatch();
    start();
  }
  int get cols => FieldSize.sizes[mode]!.cols;
  int get rows => FieldSize.sizes[mode]!.rows;
  bool get isStart => state == GameState.start;
  bool get isRepeat => state == GameState.repeat;
  bool get isEnd => state == GameState.end;
  double get time => (stopwatch.elapsedMilliseconds / 10).round() / 100;

  void start() {
    state = GameState.start;
    nextNum = 1;
    stopwatch.reset();
    stopwatch.start();
    indexes = List.generate(cols * rows, (index) => index + 1);
    indexes.shuffle();
    fieldWidth = blockWidth * cols + (cols - 1) * blockMargin;
    fieldHeight = blockHeight * (rows + 1) + (rows - 1) * blockMargin;
  }

  void end() {
    state = GameState.end;
    next();
  }

  void next() {
    if (isStart) {
      nextNum++;
    }
    if (isEnd) {
      nextNum = 1;
    }
  }
}
