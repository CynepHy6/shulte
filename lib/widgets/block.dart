import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  final double width;
  final double height;
  final Color background;
  final Color color;
  final int value;

  const Block({
    super.key,
    required this.value,
    this.width = 40,
    this.height = 40,
    this.background = Colors.grey,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(width / 20),
      padding: EdgeInsets.all(width / 20),
      height: height,
      width: width,
      color: background,
      child: Center(
        child: Text(
          '$value',
          style: TextStyle(
            color: color,
            fontSize: 2 * width / 3,
          ),
        ),
      ),
    );
  }
}
