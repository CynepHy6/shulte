import 'package:flutter/material.dart';
import 'package:shulte/service_provider.dart';
import 'shulte/shulte_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ServiceProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shulte',
      home: SafeArea(child: ShulteScreen()),
    );
  }
}
