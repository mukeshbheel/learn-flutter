import "package:flutter/material.dart";

import '../../Components/AuthComponent.dart';
import '../../Components/GradientText.dart';
import '../../Components/LoaderButton.dart';
import '../../Components/NeumorphismContainer.dart';
import '../../Components/ResponsiveText.dart';
import '../../Utils/Constant.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        AuthComponent(
          controller: TextEditingController(),
          text: 'Email',
        ),
        const SizedBox(
          height: 20,
        ),
        AuthComponent(
          controller: TextEditingController(),
          text: 'Password',
          obscureText: true,
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: NeumorphismContainer(
            child: GestureDetector(
              onTap: () {},
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: false
                      ? LoaderButton()
                      : GradientText(
                          "Let's go",
                          gradient: pinkGradient,
                        ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: (() {
            // Get.to(ForgotPassword());
          }),
          child: ResponsiveText(
            'Forgot Password',
            style: TextStyle(
              color: Colors.red[200],
            ),
          ),
        ),
      ],
    );
  }
}
