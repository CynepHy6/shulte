import 'package:flutter/material.dart';
import 'shulte/services/result_service.dart';

class ServiceProvider extends InheritedWidget {
  final resultService = ResultService();
  ServiceProvider({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static ServiceProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ServiceProvider>()!;
  }
}
