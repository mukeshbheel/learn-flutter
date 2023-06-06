import 'package:flutter/material.dart';

class NeumorphismContainer extends StatelessWidget {
  NeumorphismContainer({
    this.child,
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  Widget? child;
  double? width;
  double? height;
  double? borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius!) : BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(4,4),
              blurRadius: 20,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-5,-5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ]
      ),
      child: child,
    );
  }
}
