import 'package:flutter/material.dart';
import 'blocks/_.dart';
import 'params.dart';

const defaultSize = 5;

class ShulteScreen extends StatefulWidget {
  const ShulteScreen({Key? key}) : super(key: key);

  @override
  _ShulteScreenState createState() => _ShulteScreenState();
}

class _ShulteScreenState extends State<ShulteScreen> {
  int size = defaultSize;
  Params params = Params(rows: defaultSize, cols: defaultSize);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shulte'),
        actions: modes(),
      ),
      body: Center(child: Field(params: params)),
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

  Widget modeButton(int newSize, IconData iconData) {
    return IconButton(
      icon: Icon(iconData, color: Colors.grey.shade300),
      onPressed: () => setState(() {
        size = newSize;
        params = Params(rows: size, cols: size);
      }),
    );
  }
}
