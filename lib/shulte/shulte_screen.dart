import 'package:flutter/material.dart';
import 'blocks/_.dart';
import 'configs/enums.dart';
import 'params.dart';

const defaultMode = GameMode.debug;

class ShulteScreen extends StatefulWidget {
  const ShulteScreen({Key? key}) : super(key: key);

  @override
  _ShulteScreenState createState() => _ShulteScreenState();
}

class _ShulteScreenState extends State<ShulteScreen> {
  GameMode mode = defaultMode;
  Params params = Params(mode: defaultMode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shulte'),
        actions: modes(),
      ),
      body: Center(child: Field(params: params)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => setState(() {
          params = Params(mode: mode);
        }),
        child: const Icon(
          Icons.replay,
          color: Colors.blue,
        ),
      ),
    );
  }

  List<Widget> modes() {
    return [
      modeButton(GameMode.x3, Icons.looks_3),
      modeButton(GameMode.x4, Icons.looks_4),
      modeButton(GameMode.x5, Icons.looks_5),
      modeButton(GameMode.x6, Icons.looks_6),
    ];
  }

  Widget modeButton(GameMode newMode, IconData iconData) {
    return IconButton(
      icon: Icon(iconData, color: Colors.grey.shade300),
      onPressed: () => setState(() {
        mode = newMode;
        params = Params(mode: mode);
      }),
    );
  }
}
