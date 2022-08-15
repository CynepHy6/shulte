import 'package:flutter/material.dart';

import '_.dart';
import '../params.dart';

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
  double time = 0;
  int nextNum = 1;

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
        time = 0;
        nextNum = 1;
        params.start();
      }),
    );
  }

  successTapCallback() => setState(() {
        time = params.time;
        nextNum = params.nextNum;
      });

  Widget gameScreen() {
    final blocks = params.indexes
        .map((idx) => Block(
              idx: idx,
              params: params,
              callback: successTapCallback,
            ))
        .toList();
    return SizedBox(
      height: params.fieldHeight,
      width: params.fieldWidth,
      child: Column(
        children: [
          FieldTitle(
            nextNum: nextNum,
            time: time,
            width: params.fieldWidth,
          ),
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
}
