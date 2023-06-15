import 'package:flutter/material.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';
import 'package:learn_flutter/Login.dart';

import 'Components/GradientText.dart';
import 'Components/NeumorphismContainer.dart';
import 'Components/NeumorphismIcon.dart';
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  NeumorphismContainer(
                    borderRadius: 60,
                    child: ClipRRect( borderRadius: BorderRadius.circular(60), child: Image.network('https://latestforyouth.com/wp-content/uploads/2022/01/Funny-Whatsapp-DP-Pictures-012201.jpg', width: 80, height: 80, fit: BoxFit.cover,)),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        GradientText('Posts', gradient: blueGradient),
                        GradientText('90', gradient: greyGradient),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        GradientText('Followers', gradient: blueGradient),
                        GradientText('234', gradient: greyGradient),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        GradientText('Following', gradient: blueGradient),
                        GradientText('48', gradient: greyGradient),
                      ],
                    ),
                  )
                ],
              ),
            ),

            ListTile(
              title: GradientText('Light Yagami'.capitalizeFirst.toString(), gradient: pinkGradient,),
              trailing: GestureDetector(
                onTap: (){
                  if(authController.isLoggedIn()) {
                    AuthController.instance.logout();
                  }else{
                    Get.offAll(()=> Login());
                  }
                },
                child: NeumorphismIcon(child: Icon(Icons.power_settings_new, color: Colors.red,) ),
              ),
            ),

            // const SizedBox(height: 40,),
            // SizedBox(
            //   child: Obx(()=>NeumorphismContainer(
            //     child: GestureDetector(
            //       onTap: (){
            //         if(authController.isLoggedIn()) {
            //           AuthController.instance.logout();
            //         }else{
            //           Get.offAll(()=> Login());
            //         }
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            //         child: GradientText(authController.isLoggedIn() ? 'Logout' : 'Login', gradient: pinkGradient,),
            //       ),
            //     ),
            //   )),
            // ),

            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5,)
                    ),
                    child: AspectRatio( aspectRatio: 1,child: Image.network(demoUrl, fit: BoxFit.cover,)),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5,)
                    ),
                    child: AspectRatio( aspectRatio: 1,child: Image.network(demoUrl, fit: BoxFit.cover,)),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5,)
                    ),
                    child: AspectRatio( aspectRatio: 1,child: Image.network(demoUrl, fit: BoxFit.cover,)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
