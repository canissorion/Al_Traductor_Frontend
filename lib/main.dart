import 'package:flutter/material.dart';
import 'package:frontend/pages/page_controller.dart';

void main() {
  runApp(const MyApp());
}

bool value = true;
String _direccion = "";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Traductor",
      home: TPageController(value, _direccion),
    );
  }
}
