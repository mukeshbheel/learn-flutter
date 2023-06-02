import 'package:flutter/material.dart';

class NeumorphismIcon extends StatelessWidget {
  NeumorphismIcon({
    this.child,
    Key? key,
  }) : super(key: key);

  Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFBEBEBE),
              offset: Offset(10,10),
              blurRadius: 20,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-10,-10),
              blurRadius: 80,
              spreadRadius: 1,
            ),
          ]
      ),
      child: child,
    );
  }
}
