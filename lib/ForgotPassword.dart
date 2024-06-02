import 'package:flutter/material.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';

import 'Components/AuthComponent.dart';
import 'Components/EasyWriteLogoSection.dart';
import 'Components/GradientText.dart';
import 'Components/LoaderButton.dart';
import 'Components/NeumorphismContainer.dart';
import 'Utils/Constant.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  int? selectedTab = 1;
  AuthController auth = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: auth,
        builder: (_) {
          return Obx(() => Scaffold(
                backgroundColor:
                    auth.loading.value ? greyBackground : greyBackground,
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
                              Expanded(
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
                                            GradientText('Forgot Password',
                                                gradient: pinkGradient),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(
                                              Icons.arrow_circle_left,
                                              color: Colors.pink,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: InkWell(
                                    onTap: (() {
                                      Get.back();
                                    }),
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
                                              GradientText('Login',
                                                  gradient: greyGradient),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(
                                                Icons.arrow_circle_left,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthComponent(
                          controller: email,
                          text: 'Email',
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Obx(() => SizedBox(
                              child: NeumorphismContainer(
                                child: GestureDetector(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (!auth.passwordResetLinkButtonIsDisabled
                                        .value)
                                      auth.forgotPassword(email: email.text);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: auth.loading.value
                                        ? LoaderButton()
                                        : GradientText(
                                            auth.passwordResetLinkButtonIsDisabled
                                                    .value
                                                ? 'Check Email to set password'
                                                : 'Send Reset Email',
                                            gradient: auth
                                                    .passwordResetLinkButtonIsDisabled
                                                    .value
                                                ? greyGradient
                                                : pinkGradient,
                                          ),
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        if (auth.passwordResetLinkSent.value)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Center(
                              child: GradientText(
                                'Password Reset Link sent to your email address.',
                                gradient: greenGradient,
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
              ));
        });
  }
}
