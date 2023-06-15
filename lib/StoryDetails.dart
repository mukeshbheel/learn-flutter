import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/NewStory.dart';
import 'Components/GradientText.dart';
import 'Components/NeumorphismContainer.dart';
import 'Components/ResponsiveText.dart';
import 'Controller/Auth_controller.dart';
import 'Controller/Home_controller.dart';
import 'RandomWordStory.dart';
import 'Utils/Constant.dart';

class StoryDetails extends StatefulWidget {
  StoryDetails({Key? key}) : super(key: key);

  @override
  State<StoryDetails> createState() => _StoryDetailsState();
}

class _StoryDetailsState extends State<StoryDetails> {

  final controller = Get.put(HomeController());
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Obx(() => Scaffold(
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 50,),

                Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: NeumorphismContainer(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 10),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width:
                                    double.infinity * 0.5,
                                    // height: 100,
                                    child: ClipRRect(
                                        borderRadius:
                                        BorderRadius
                                            .circular(12),
                                        child: Image.network(
                                          controller
                                              .selectedStory[
                                          'image'],
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GradientText(
                                    controller.selectedStory[
                                    'title'],
                                    gradient: greenGradient,
                                    style: TextStyle(
                                      fontFamily: kFontFamily,
                                      color: Colors.black87,
                                      letterSpacing: 1,
                                      wordSpacing: 3,
                                      height: 2,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (controller
                                      .selectedStory[
                                  'type'] ==
                                      1)
                                    ResponsiveText(
                                      controller
                                          .selectedStory[
                                      'story'],
                                      style: TextStyle(
                                        fontFamily:
                                        kFontFamily,
                                        color: Colors.black87,
                                        letterSpacing: 1,
                                        wordSpacing: 3,
                                        height: 2,
                                      ),
                                    ),
                                  if (controller
                                      .selectedStory[
                                  'type'] ==
                                      2)
                                    Html(
                                      data: controller
                                          .selectedStory[
                                      'story'],
                                      style: {
                                        // p tag with text_size
                                        "body": Style(
                                            fontSize:
                                            const FontSize(
                                                14),
                                            fontFamily:
                                            kFontFamily,
                                            letterSpacing: 1,
                                            wordSpacing: 3,
                                            lineHeight:
                                            const LineHeight(
                                                2)),
                                      },
                                    ),

                                  // Text('uuid : ${AuthController.instance.getCurretUId()}'),
                                  // Text('story uuid : ${controller.selectedStory['uuid']}'),
                                  if (AuthController.instance
                                      .isLoggedIn() &&
                                      controller.selectedStory[
                                      'uuid'] ==
                                          AuthController
                                              .instance
                                              .getCurretUId())
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  controller
                                                      .editing();
                                                  Get.to(NewStory());
                                                },
                                                child:
                                                NeumorphismContainer(
                                                  width: 200,
                                                  // height: 100,
                                                  child:
                                                  Center(
                                                    child:
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal:
                                                          20.0,
                                                          vertical:
                                                          10),
                                                      child:
                                                      GradientText(
                                                        controller.selectedStory.value['type'] == 2 ? 'Continue':'Edit',
                                                        gradient:
                                                        greenGradient,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap:
                                                    () async {
                                                  controller.deleteStory(
                                                      controller
                                                          .selectedStory,
                                                      context);
                                                },
                                                child:
                                                NeumorphismContainer(
                                                  width: 200,
                                                  // height: 100,
                                                  child:
                                                  Center(
                                                    child:
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal:
                                                          20.0,
                                                          vertical:
                                                          10),
                                                      child:
                                                      GradientText(
                                                        'Delete',
                                                        gradient:
                                                        redGradient,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 20,
                      top: 30,
                      child: NeumorphismContainer(
                        borderRadius: 60,
                        child: IconButton(
                          onPressed: () {
                            // controller.selectStory(null);
                            Get.back();
                          },
                          icon: const Icon(Icons.reply),
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
      }
    );
  }
}
