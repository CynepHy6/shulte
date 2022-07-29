import 'package:flutter/material.dart';

import 'block.dart';

class Field extends StatefulWidget {
  final int rows;
  final int cols;
  final double blockWidth;
  final double blockHeight;
  List<int> idxs = [];
  double? width;
  double? height;
  final stopwatch = Stopwatch();
  int nextNum = 1;
  double time = 0;

  Field({
    super.key,
    required this.rows,
    required this.cols,
    this.blockWidth = 40,
    this.blockHeight = 40,
  }) {
    stopwatch.reset();
    stopwatch.start();

    idxs = createIdxs(cols, rows);
    width = blockWidth * cols + (cols - 1) * blockWidth / 20;
    height = blockHeight * rows + (rows - 1) * blockHeight / 20;
  }
  final initNextNum = 1;
  bool isEnd = false;

  @override
  _FieldState createState() => _FieldState();

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
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    List<Widget> blocks = generateBlocks();

    return Stack(children: [
      if (widget.isEnd) endScreen(),
      if (!widget.isEnd) gameScreen(blocks),
    ]);
  }

  Widget endScreen() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.green.shade100,
      child: Center(
        child: Text(
          '${widget.time}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
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
          Text('${widget.nextNum}'),
          Text('${widget.time}'),
        ],
      ),
    );
  }

  Widget blockTap(int idx) {
    return GestureDetector(
      onTap: () {
        if (idx != widget.nextNum) {
          return;
        }
        setState(() {
          if (idx == widget.cols * widget.rows) {
            widget.isEnd = true;
          }
          widget.nextNum = widget.nextNum + 1;
          widget.time = (widget.stopwatch.elapsedMilliseconds / 10).round() / 100;
        });
      },
      child: Block(
        width: widget.blockWidth,
        height: widget.blockHeight,
        value: idx,
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
}
