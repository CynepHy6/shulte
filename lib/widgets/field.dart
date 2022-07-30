import 'package:flutter/material.dart';

import 'block.dart';

enum GameState { start, end, repeat }

class Field extends StatefulWidget {
  final int rows;
  final int cols;
  final double blockWidth;
  final double blockHeight;
  final double gap;
  double? width;
  double? height;
  final stopwatch = Stopwatch();
  int nextNum = 1;
  double time = 0;
  GameState? state;
  List<int> idxs = [];
  List<Widget> blocks = [];

  Field({
    super.key,
    required this.rows,
    required this.cols,
    this.blockWidth = 60,
    this.blockHeight = 60,
    this.gap = 1,
  }) {
    state = GameState.repeat;
    width = blockWidth * cols + (cols - 1) * blockWidth / 20;
    height = blockHeight * rows + (rows - 1) * blockHeight / 20;
  }

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    startGame();

    return Stack(children: [
      if (widget.state == GameState.end) endScreen(),
      if (widget.state == GameState.start) gameScreen(widget.blocks),
    ]);
  }

  void startGame() {
    if (widget.state != GameState.repeat) return;
    widget.time = 0;
    widget.nextNum = 1;
    widget.stopwatch.reset();
    widget.stopwatch.start();
    widget.idxs = createIdxs(widget.cols, widget.rows);
    widget.blocks = generateBlocks();
    widget.state = GameState.start;
  }

  List<int> createIdxs(int cols, int rows) {
    List<int> idxs = [];
    for (var col = 0; col < cols; col++) {
      for (var row = 0; row < rows; row++) {
        idxs.add(idxs.length + 1);
      }
    }
    idxs.shuffle();
    return idxs;
  }

  Widget endScreen() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.green.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${widget.time}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          repeatButton(),
        ],
      ),
    );
  }

  Widget repeatButton() {
    return IconButton(
      icon: Icon(Icons.replay_circle_filled_outlined, color: Colors.grey.shade800),
      onPressed: () => setState(() {
        widget.state = GameState.repeat;
        startGame();
      }),
    );
  }

  Widget gameScreen(List<Widget> blocks) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        titleRow(),
        ...blocks,
      ],
    );
  }

  Widget titleRow() {
    return SizedBox(
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '${widget.nextNum}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('${widget.time}'),
        ],
      ),
    );
  }

  List<Widget> generateBlocks() {
    List<Widget> blocks = [];
    int idx = 0;
    for (var col = 0; col < widget.cols; col++) {
      List<Widget> line = [];
      for (var row = 0; row < widget.rows; row++) {
        line.add(
          blockTap(widget.idxs[idx]),
        );
        idx++;
      }
      blocks.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [...line],
      ));
    }

    return blocks;
  }

  Widget blockTap(int idx) {
    return GestureDetector(
      onTap: () {
        if (idx != widget.nextNum) {
          return;
        }
        setState(() {
          if (idx == widget.cols * widget.rows) {
            widget.state = GameState.end;
          }
          widget.nextNum = widget.nextNum + 1;
          widget.time = (widget.stopwatch.elapsedMilliseconds / 10).round() / 100;
        });
      },
      child: Block(
        width: widget.blockWidth,
        height: widget.blockHeight,
        value: idx,
        gap: widget.gap,
      ),
    );
  }
}
