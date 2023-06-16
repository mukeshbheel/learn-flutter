import 'package:flutter/material.dart';

class LoaderButton extends StatelessWidget {
  LoaderButton({
    Key? key,
    this.width : 100,
    this.color : Colors.pink,
    this.loaderSize : 20,
    this.strokeWidth : 2,
  }) : super(key: key);

  double width;
  double loaderSize;
  Color color;
  double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: loaderSize,
            height: loaderSize,
            child:CircularProgressIndicator(color: color, strokeWidth: 2, ),
          ),
        ],
      ),
    );
  }
}
