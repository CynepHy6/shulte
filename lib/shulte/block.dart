import 'dart:async';

import 'package:flutter/material.dart';

import 'params.dart';

class Block extends StatefulWidget {
  final int idx;
  final Params params;
  Block({
    Key? key,
    required this.idx,
    required this.params,
  }) : super(key: key);

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  Params get params => widget.params;
  int get idx => widget.idx;

  late Color background;
  @override
  void initState() {
    super.initState();
    background = widget.params.background;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (context) {
        Timer(
          const Duration(milliseconds: 200),
          () => setState(() {
            background = Colors.grey.shade200;
          }),
        );
        setState(() {
          print('tap block $idx ${params.nextNum}');
          if (idx != params.nextNum) {
            background = Colors.red;
            return;
          }
          background = Colors.green;
          if (idx == params.indexes.length) {
            params.end();
          }
          params.next();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.all(params.blockMargin),
        padding: EdgeInsets.all(params.blockWidth / 20),
        width: params.blockWidth,
        color: background,
        height: params.blockHeight,
        child: Center(
          child: Text(
            '$idx',
            style: TextStyle(color: params.color, fontSize: params.blockFontSize),
          ),
        ),
      ),
    );
  }
}
