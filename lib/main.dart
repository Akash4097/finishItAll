import 'package:finish_it_all/common/app_logger/app_logger.dart';
import 'package:flutter/material.dart';

final appLogger = AppLogger.init();
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
