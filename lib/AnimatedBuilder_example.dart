import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBuilderExample extends StatefulWidget {
  const AnimatedBuilderExample({Key? key}) : super(key: key);

  @override
  _AnimatedBuilderExampleState createState() => _AnimatedBuilderExampleState();
}

class _AnimatedBuilderExampleState extends State<AnimatedBuilderExample>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 10))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Builder'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        child: Center(
          child: Container(
            width: 50,
            height: 50,
            color: Colors.blue,
            child: Icon(Icons.face),
          ),
        ),
        builder: (context, child) => Transform.rotate(
          // angle: _controller.value,
          angle: _controller.value * 5 * math.pi,
          child: child,
        ),
      ),
    );
  }
}
