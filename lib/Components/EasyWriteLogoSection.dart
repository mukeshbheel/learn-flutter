import 'package:flutter/material.dart';
import 'package:learn_flutter/Components/GradientText.dart';
import 'package:learn_flutter/Components/NeumorphismContainer.dart';

import '../Utils/Constant.dart';

class EasyWriteLogoSection extends StatelessWidget {
  const EasyWriteLogoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      fontWeight: FontWeight.bold),
                  gradient: pinkGradient,
                ),
                const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.pink,
                )
              ],
            ),
          )),
    );
  }
}
