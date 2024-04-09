import 'package:flutter/material.dart';
import 'package:learn_flutter/Components/ResponsiveText.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';
import 'package:learn_flutter/EditProfile.dart';
import 'package:learn_flutter/Login.dart';

import 'Components/GradientText.dart';
import 'Components/NeumorphismContainer.dart';
import 'Components/NeumorphismIcon.dart';
import 'Controller/Home_controller.dart';
import 'StoryDetails.dart';
import 'Utils/Constant.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  final controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return StreamBuilder(
          stream: controller.firestore.collection("myStories").where('uuid', isEqualTo: authController.getCurretUId()).snapshots(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: Get.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40,),
                    NeumorphismContainerWithPadding(
                      horizontalPadding: 20,
                      child: ResponsiveText('Settings', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blue),),
                    ),
                    const SizedBox(height: 20,),
                    NeumorphismContainerWithPadding(
                      width: Get.size.width,
                      verticalPadding: 20,
                      child: ResponsiveText('Change your password', style: TextStyle(color: Colors.black),),
                    )

                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}
