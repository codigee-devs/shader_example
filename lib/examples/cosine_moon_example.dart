import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shader_example/shaders_cache.dart';

class CosineMoonExample extends StatelessWidget {
  const CosineMoonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final shaderCache = ShadersCache();

    return FutureBuilder(
      future: shaderCache.initialize(),
      builder: (_, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? ShaderShowcase(shaderCache.cosineMoon)
            : const Placeholder();
      },
    );
  }
}

class ShaderShowcase extends StatefulWidget {
  const ShaderShowcase(this._shader, {super.key});
  final FragmentShader _shader;

  @override
  State<ShaderShowcase> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ShaderShowcase>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 500),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (event) {
        setState(() {
          _mousePosition = event.position;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: CosineMoonPainter(
              widget._shader,
              _controller.value,
              _mousePosition,
            ),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class CosineMoonPainter extends CustomPainter {
  const CosineMoonPainter(
    this.shader,
    this.animation,
    this.mousePosition,
  );

  final FragmentShader shader;
  final double animation;
  final Offset mousePosition;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width); // resolution
    shader.setFloat(1, size.height); // resolution
    shader.setFloat(2, mousePosition.dx); // mouse
    shader.setFloat(3, mousePosition.dy); // mouse
    shader.setFloat(4, animation * 1000); // time

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
