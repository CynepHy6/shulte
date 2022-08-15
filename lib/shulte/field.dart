import 'package:flutter/material.dart';

import 'block.dart';
import 'params.dart';

class Field extends StatefulWidget {
  Params params;
  Field({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  Params get params => widget.params;

  @override
  Widget build(BuildContext context) {
    startGame(params);

    return Stack(children: [
      if (params.isEnd) endScreen(),
      if (params.isStart) gameScreen(),
    ]);
  }

  void startGame(Params field) {
    if (field.isRepeat) field.start();
  }

  Widget endScreen() {
    return Container(
      width: params.fieldWidth,
      height: params.fieldHeight,
      color: params.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${params.time}',
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
        params.start();
      }),
    );
  }

  Widget gameScreen() {
    final blocks = params.indexes
        .map((idx) => Block(
              idx: idx,
              params: params,
            ))
        .toList();
    return SizedBox(
      height: params.fieldHeight,
      width: params.fieldWidth,
      child: Column(
        children: [
          titleRow(),
          Expanded(
            child: GridView.count(
              crossAxisCount: params.cols,
              children: blocks,
            ),
          ),
        ],
      ),
    );
  }

  Widget titleRow() {
    return SizedBox(
      width: params.fieldWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '${params.nextNum}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('${params.time}'),
        ],
      ),
    );
  }
}
