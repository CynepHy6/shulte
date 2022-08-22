import 'package:flutter/material.dart';
import 'configs/enums.dart';
import 'result.dart';
import 'configs/field_size.dart';

class Params {
  Map<GameMode, List<Result>> results = <GameMode, List<Result>>{};
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
  late double time;
  late Stopwatch stopwatch;

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

  void start() {
    state = GameState.start;
    nextNum = 1;
    time = 0;
    stopwatch.reset();
    stopwatch.start();
    indexes = List.generate(cols * rows, (index) => index + 1);
    indexes.shuffle();
    fieldWidth = blockWidth * cols + (cols - 1) * blockMargin;
    fieldHeight = blockHeight * (rows + 1) + (rows - 1) * blockMargin;
  }

  void end() {
    time = (stopwatch.elapsedMilliseconds / 10).round() / 100;
    saveResult();
    time = 0;
    nextNum = 1;
    state = GameState.end;
  }

  void next() {
    if (!isStart) return;
    nextNum++;
    time = (stopwatch.elapsedMilliseconds / 10).round() / 100;
  }

  saveResult() {
    if (results[mode] == null) {
      results[mode] = [];
    }
    results[mode]!.add(Result(time: time, date: DateTime.now()));
  }
}
