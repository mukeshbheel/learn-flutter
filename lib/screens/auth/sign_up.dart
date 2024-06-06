import "package:flutter/material.dart";

import '../../Components/AuthComponent.dart';
import '../../Components/GradientText.dart';
import '../../Components/LoaderButton.dart';
import '../../Components/NeumorphismContainer.dart';
import '../../Components/ResponsiveText.dart';
import '../../Utils/Constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          AuthComponent(
            controller: TextEditingController(),
            text: 'Name',
          ),
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
                            'Create Account',
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
        ],
      ),
    );
  }
}
