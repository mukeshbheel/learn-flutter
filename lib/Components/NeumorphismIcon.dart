import 'package:flutter/material.dart';
import 'package:learn_flutter/Utils/Constant.dart';

class NeumorphismIcon extends StatelessWidget {
  NeumorphismIcon({
    this.child,
    this.width = 50,
    this.hight = 50,
    Key? key,
  }) : super(key: key);

  Widget? child;
  double width;
  double hight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: greyBackground,
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: greyShadowColor,
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
