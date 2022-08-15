import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final int nextNum;
  final double time;
  final double? width;
  const FieldTitle({
    Key? key,
    required this.nextNum,
    required this.time,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '$nextNum',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$time'),
        ],
      ),
    );
  }
}
