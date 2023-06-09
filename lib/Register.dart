import 'package:flutter/material.dart';

import 'Components/GradientText.dart';
import 'Components/NeumorphismContainer.dart';
import 'Utils/Constant.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80,),
          Center(
            child: NeumorphismContainer(
                borderRadius: 12,
                height: 100,
                width: 200,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GradientText(
                        'Easy Write',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: kFontFamily,
                            fontWeight: FontWeight.bold
                        ), gradient: pinkGradient,
                      ),
                      const Icon(Icons.menu_book_rounded, color: Colors.pink,)
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
