import 'package:flutter/material.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';
import 'package:learn_flutter/Login.dart';

import 'Components/GradientText.dart';
import 'Components/NeumorphismContainer.dart';
import 'Utils/Constant.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: Get.size.width,
        child: Column(
          children: [
            const SizedBox(height: 40,),
            SizedBox(
              child: Obx(()=>NeumorphismContainer(
                child: GestureDetector(
                  onTap: (){
                    if(authController.isLoggedIn()) {
                      AuthController.instance.logout();
                    }else{
                      Get.offAll(()=> Login());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: GradientText(authController.isLoggedIn() ? 'Logout' : 'Login', gradient: pinkGradient,),
                  ),
                ),
              )),
            ),

            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
