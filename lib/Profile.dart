import 'package:flutter/material.dart';
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

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
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
            return Obx(() => SingleChildScrollView(
              child: SizedBox(
                width: Get.size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          NeumorphismContainer(
                            borderRadius: 60,
                            child: ClipRRect( borderRadius: BorderRadius.circular(60), child: Image.network( authController.imageUrl.value.isNotEmpty ? authController.imageUrl.value  : 'https://latestforyouth.com/wp-content/uploads/2022/01/Funny-Whatsapp-DP-Pictures-012201.jpg', width: 80, height: 80, fit: BoxFit.cover,)),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                GradientText('Posts', gradient: blueGradient),
                                GradientText('${snapshot.data?.docs.length}', gradient: greyGradient),
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

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientText('${authController.name.value.isNotEmpty ? authController.name.value : 'user name'}', gradient: pinkGradient,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(EditProfile());
                                },
                                child: NeumorphismIcon(child: const Icon(Icons.edit, color: Colors.blue,),),
                              ),
                              const SizedBox(width: 5,),
                              GestureDetector(
                                onTap: (){
                                  if(authController.isLoggedIn()) {
                                    AuthController.instance.logout();
                                  }else{
                                    Get.offAll(()=> Login());
                                  }
                                },
                                child: NeumorphismIcon(child: const Icon(Icons.power_settings_new, color: Colors.red,) ),
                              ),

                            ],
                          ),
                        ],
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

                    const SizedBox(height: 20,),
                    !snapshot.hasData
                        ? GradientText('Loading ...',
                        gradient: greenGradient)
                        : Column(
                      children: [
                        if(snapshot.data!.docs.isNotEmpty)
                          ...List.generate(
                              (snapshot
                                  .data!.docs.length/3).ceil(),
                                  (index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            controller.selectStory(
                                                snapshot.data!
                                                    .docs[
                                                index*3]);
                                            Get.to(StoryDetails());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              // border: Border.all(color: Colors.black, width: 5,)
                                            ),
                                            child: NeumorphismContainer(child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  AspectRatio( aspectRatio: 1,child: Image.network(snapshot.data!.docs[index*3 + 0]['image'], fit: BoxFit.cover,)),
                                                  GradientText(snapshot.data!.docs[index*3]['title'], gradient: greyGradient,)
                                                ],
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: snapshot.data!.docs. asMap(). containsKey(index*3 + 1) ? InkWell(
                                          onTap: () {
                                            controller.selectStory(
                                                snapshot.data!
                                                    .docs[
                                                index*3 + 1]);
                                            Get.to(StoryDetails());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              // border: Border.all(color: Colors.black, width: 5,)
                                            ),
                                            child: NeumorphismContainer(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    AspectRatio( aspectRatio: 1, child: Image.network(snapshot.data!.docs[index*3 + 1]['image'], fit: BoxFit.cover,)),
                                                    GradientText(snapshot.data!.docs[index*3 + 1]['title'], gradient: greyGradient,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ) : const SizedBox(),
                                      ),
                                      Expanded(
                                        child: snapshot.data!.docs. asMap(). containsKey(index*3 + 2) ? InkWell(
                                          onTap: () {
                                            controller.selectStory(
                                                snapshot.data!
                                                    .docs[
                                                index*3 + 2]);
                                            Get.to(StoryDetails());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              // border: Border.all(color: Colors.black, width: 5,)
                                            ),
                                            child: NeumorphismContainer(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    AspectRatio( aspectRatio: 1, child: Image.network(snapshot.data!.docs[index*3 + 2]['image'], fit: BoxFit.cover,)),
                                                    GradientText(snapshot.data!.docs[index*3 + 2]['title'], gradient: greyGradient,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ) : const SizedBox(),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        // ResponsiveText('chintu'),
                      ],
                    ),
                    // ...List.generate(2, (index) => Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: Colors.black, width: 5,)
                    //         ),
                    //         child: AspectRatio( aspectRatio: 1,child: Image.network(demoUrl, fit: BoxFit.cover,)),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: Colors.black, width: 5,)
                    //         ),
                    //         child: AspectRatio( aspectRatio: 1,child: Image.network(demoUrl, fit: BoxFit.cover,)),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: Colors.black, width: 5,)
                    //         ),
                    //         child: AspectRatio( aspectRatio: 1,child: Image.network(demoUrl, fit: BoxFit.cover,)),
                    //       ),
                    //     ),
                    //   ],
                    // )),

                    const SizedBox(height: 40,),
                  ],
                ),
              ),
            ));
          }
        );
      }
    );
  }
}
