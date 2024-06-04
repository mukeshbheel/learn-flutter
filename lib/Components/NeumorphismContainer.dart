import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/Utils/Constant.dart';

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
          color: greyBackground,
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: greyShadowColor,
              offset: Offset(4, 4),
              blurRadius: 20,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ]),
      child: child,
    );
  }
}

class NeumorphismContainerWithPadding extends StatelessWidget {
  NeumorphismContainerWithPadding(
      {this.child,
      Key? key,
      this.width,
      this.borderRadius,
      this.horizontalPadding,
      this.verticalPadding})
      : super(key: key);

  Widget? child;
  double? width;
  double? height;
  double? borderRadius = 8;
  double? horizontalPadding = 8;
  double? verticalPadding = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 8, vertical: verticalPadding ?? 8),
      decoration: BoxDecoration(
          color: greyBackground,
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: greyShadowColor,
              offset: Offset(4, 4),
              blurRadius: 20,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ]),
      child: child,
    );
  }
}
