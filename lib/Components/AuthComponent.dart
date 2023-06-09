import 'package:flutter/material.dart';

import '../Utils/Constant.dart';
import 'GradientText.dart';
import 'NeumorphismContainer.dart';

class AuthComponent extends StatelessWidget {
  AuthComponent({Key? key, required this.controller, this.padding = 20, this.text = 'text', this.obscureText = false}) : super(key: key);

  final TextEditingController controller;
  double? padding;
  String? text;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientText(text!, gradient: pinkGradient),
          const SizedBox(height: 20,),
          NeumorphismContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: TextField(
                controller: controller,
                obscureText: obscureText!,
                decoration: const InputDecoration(
                  border: InputBorder.none
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
