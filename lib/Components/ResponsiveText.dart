import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  ResponsiveText(this.text,{
    Key? key,
    this.style,
  }) : super(key: key);
  String? text = 'text';
  TextStyle? style = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: style
      ),
    );
  }
}
