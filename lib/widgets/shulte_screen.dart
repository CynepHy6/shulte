import 'package:flutter/material.dart';
import 'field.dart';

const defaultSize = 5;

class ShulteScreen extends StatefulWidget {
  const ShulteScreen({Key? key}) : super(key: key);

  @override
  _ShulteScreenState createState() => _ShulteScreenState();
}

class _ShulteScreenState extends State<ShulteScreen> {
  Field field = Field(
    rows: defaultSize,
    cols: defaultSize,
  );
  int size = defaultSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shulte'),
        actions: modes(),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(flex: 1),
              field,
              const Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> modes() {
    return [
      modeButton(3, Icons.looks_3),
      modeButton(4, Icons.looks_4),
      modeButton(5, Icons.looks_5),
      modeButton(6, Icons.looks_6),
      const SizedBox(width: 20),
      modeButton(size, Icons.replay_circle_filled_outlined),
    ];
  }

  mode(int newSize) {}

  Widget modeButton(int newSize, IconData iconData) {
    return IconButton(
      icon: Icon(iconData, color: Colors.grey.shade300),
      onPressed: () => setState(() {
        size = newSize;
        field = Field(
          rows: size,
          cols: size,
        );
      }),
    );
  }
}
