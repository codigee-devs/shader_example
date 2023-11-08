import 'package:flutter/material.dart';
import 'package:shader_example/examples/cosine_moon_example.dart';
import 'package:shader_example/examples/scene_is_dead_example.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: CosineMoonExample(),
        // body: SceneIsDeadExample(), // Uncomment for extra
      ),
    );
  }
}
