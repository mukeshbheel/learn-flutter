import 'package:flutter/material.dart';
import 'package:learn_flutter/Components/EasyWriteLogoSection.dart';
import 'package:learn_flutter/Components/ResponsiveText.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';
import 'package:learn_flutter/Controller/NavigationBarController.dart';
import 'package:learn_flutter/ForgotPassword.dart';
import 'package:learn_flutter/NavigationBar_example.dart';

import 'Components/AuthComponent.dart';
import 'Components/GradientText.dart';
import 'Components/LoaderButton.dart';
import 'Components/NeumorphismContainer.dart';
import 'Utils/Constant.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  Login({Key? key, this.selectedTab = 0}) : super(key: key);
  int? selectedTab;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int selectedTab = 0;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedTab = widget.selectedTab!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          // width: Get.size.width,
          // height: 500,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const EasyWriteLogoSection(),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                      2,
                      (index) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTab = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: NeumorphismContainer(
                                  // width: 100,
                                  height: 50,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GradientText(
                                            index == 0 ? 'Login' : 'Register',
                                            gradient: selectedTab == index
                                                ? pinkGradient
                                                : greyGradient,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          selectedTab == index
                                              ? const Icon(
                                                  Icons.arrow_circle_left,
                                                  color: Colors.pink,
                                                )
                                              : const Icon(
                                                  Icons.arrow_circle_left,
                                                  color: Colors.grey,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ],
              ),
              if (selectedTab == 1)
                const SizedBox(
                  height: 30,
                ),
              if (selectedTab == 1)
                AuthComponent(
                  controller: name,
                  text: 'Name',
                ),
              const SizedBox(
                height: 30,
              ),
              AuthComponent(
                controller: email,
                text: 'Email',
              ),
              const SizedBox(
                height: 20,
              ),
              AuthComponent(
                controller: password,
                text: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (() {
                  Get.to(ForgotPassword());
                }),
                child: ResponsiveText(
                  'Forgot Password',
                  style: TextStyle(
                    color: Colors.red[200],
                  ),
                ),
              ),
              if (selectedTab == 1)
                const SizedBox(
                  height: 20,
                ),
              if (selectedTab == 1)
                AuthComponent(
                  controller: confirmPassword,
                  text: 'ConfirmPassword',
                  obscureText: true,
                ),
              const SizedBox(
                height: 40,
              ),
              Obx(() => SizedBox(
                    child: NeumorphismContainer(
                      child: GestureDetector(
                        onTap: () {
                          if (selectedTab == 1) {
                            AuthController.instance.register(
                                email.text.trim(),
                                password.text.trim(),
                                confirmPassword.text.trim(),
                                name.text.trim());
                          } else {
                            AuthController.instance
                                .login(email.text.trim(), password.text.trim());
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: AuthController.instance.loading.value
                              ? LoaderButton()
                              : GradientText(
                                  selectedTab == 0 ? 'Login' : 'Register',
                                  gradient: pinkGradient,
                                ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                child: NeumorphismContainer(
                  child: GestureDetector(
                    onTap: () {
                      if (Get.isRegistered<NavigationBarController>() !=
                          false) {
                        Get.find<NavigationBarController>().currentIndex.value =
                            0;
                      }
                      Get.to(() => const NavigationBarExample());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: GradientText(
                        'Continue as a Guest',
                        gradient: pinkGradient,
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
        ),
      ),
    );
  }
}
