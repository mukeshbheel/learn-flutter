import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_flutter/Components/GradientText.dart';
import 'package:learn_flutter/Components/NeumorphismContainer.dart';
import 'package:learn_flutter/Utils/Constant.dart';
import 'package:learn_flutter/screens/auth/sign_in.dart';

import 'sign_up.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  int tabBarIndex = 0;

  @override
  void initState() {
    tabController = new TabController(
      length: 2,
      vsync: this,
      initialIndex: tabBarIndex,
    );
    tabController.addListener(() {
      setState(() {
        tabBarIndex = tabController.index;
      });
      print("Selected Index: " + tabController.index.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, -1.5),
                child: Container(
                  width: screenWidth,
                  height: screenWidth,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.orange.shade300),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-2.7, -1.5),
                child: Container(
                  width: screenWidth / 1.3,
                  height: screenWidth / 1.3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.pink.shade300),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(2.7, -1.5),
                child: Container(
                  width: screenWidth / 1.3,
                  height: screenWidth / 1.3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple.shade300),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight / 1.5,
                  child: Column(
                    children: [
                      TabBar(
                        controller: tabController,
                        unselectedLabelColor: greyShadowColor,
                        labelColor: Color.fromARGB(255, 175, 81, 74),
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        tabs: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: NeumorphismContainer(
                              // width: 100,
                              height: 50,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GradientText(
                                        'Sign In',
                                        gradient: tabController.index == 0
                                            ? pinkGradient
                                            : greyGradient,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      tabController.index == 0
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: NeumorphismContainer(
                              // width: 100,
                              height: 50,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GradientText(
                                        'Sign Up',
                                        gradient: tabController.index == 1
                                            ? pinkGradient
                                            : greyGradient,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      tabController.index == 1
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

                          // Padding(
                          //   padding: EdgeInsets.all(12),
                          //   child: Text(
                          //     'Sign Up',
                          //     style: TextStyle(
                          //       fontSize: 18,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            SignIn(),
                            SignUp(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
