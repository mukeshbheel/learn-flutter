import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/Components/GradientText.dart';
import 'package:learn_flutter/Components/NeumorphismContainer.dart';
import 'package:learn_flutter/Controller/Home_controller.dart';
import 'package:learn_flutter/NewStory.dart';
import 'package:learn_flutter/Utils/Constant.dart';
import 'Controller/Auth_controller.dart';
import 'StoryDetails.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(HomeController());
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
      controller.selectedTab.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (controller) {
          return StreamBuilder(
              stream: controller.firestore.collection('myStories').snapshots(),
              builder: (context, snapshot) {
                return Obx(() => SingleChildScrollView(
                      child: Container(
                        color: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Center(
                              child: NeumorphismContainer(
                                  borderRadius: 12,
                                  height: 100,
                                  width: 200,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GradientText(
                                          'Easy Write',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: kFontFamily,
                                              fontWeight: FontWeight.bold),
                                          gradient: pinkGradient,
                                        ),
                                        const Icon(
                                          Icons.menu_book_rounded,
                                          color: Colors.pink,
                                        )
                                      ],
                                    ),
                                  )),
                            ),

                            //-------------------------------section 2---------------------------

                            if (!AuthController.instance.isLoggedIn())
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  NeumorphismContainer(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 15),
                                      child: GradientText(
                                        'You need to Login to create your own stories.',
                                        gradient: controller.getGradient(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            if (AuthController.instance.isLoggedIn())
                              const SizedBox(
                                height: 50,
                              ),
                            if (AuthController.instance.isLoggedIn())
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          // controller.selectTab(1);
                                          controller.reset();
                                          controller.selectType(1);
                                          Get.to(const NewStory());
                                        },
                                        child: Center(
                                          child: NeumorphismContainer(
                                              borderRadius: 12,
                                              height: 150,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                            Icons.create,
                                                            color: Colors.blue,
                                                            size: 30,
                                                          ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    GradientText(
                                                          'New Story',
                                                      style: const TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'JosefinSans',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      gradient: blueGradient,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          controller.selectTab(2);
                                        },
                                        child: Center(
                                          child: NeumorphismContainer(
                                              borderRadius: 12,
                                              height: 150,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    controller.selectedTab == 2
                                                        ? const Icon(
                                                            Icons.reply,
                                                            color: Colors.green,
                                                            size: 30,
                                                          )
                                                        : const Icon(
                                                            Icons.museum,
                                                            color: Colors.green,
                                                            size: 30,
                                                          ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    GradientText(
                                                      controller.selectedTab ==
                                                              2
                                                          ? 'All Stories'
                                                          : 'Your Stories',
                                                      style: const TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'JosefinSans',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      gradient: greenGradient,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            //-------------------------------section 3--------------------------
                            // if (AuthController.instance.isLoggedIn())
                              const SizedBox(
                                height: 50,
                              ),
                            // if (AuthController.instance.isLoggedIn())
                              NeumorphismContainer(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15),
                                  child: GradientText(
                                    '${controller.getTitle()}',
                                    gradient: controller.getGradient(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                            //---------------------------------------- my stories------------------>
                            if (controller.selectedTab.value == 2)
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 15),
                                        child: !snapshot.hasData
                                            ? GradientText('Loading ... ',
                                                gradient: greenGradient)
                                            : Column(
                                                children: [
                                                  ...snapshot.data!.docs
                                                      .where((data) =>
                                                          data['uuid'] ==
                                                          authController
                                                              .uuid.value)
                                                      .map((data) => InkWell(
                                                            onTap: () {
                                                              // debugPrint(snapshot.data!.docs[index].data.toString());
                                                              controller
                                                                  .selectStory(
                                                                      data);
                                                              Get.to( StoryDetails());
                                                            },
                                                            child: Column(
                                                              children: [
                                                                NeumorphismContainer(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            8.0,
                                                                        vertical:
                                                                            10),
                                                                    child:
                                                                        ListTile(
                                                                      title:
                                                                          GradientText(
                                                                        data[
                                                                            'title'],
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: kFontFamily,
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.w500),
                                                                        gradient:
                                                                            greenGradient,
                                                                      ),
                                                                      subtitle:
                                                                          GradientText(
                                                                        data['type'] == 1
                                                                            ? 'Normal story'
                                                                            : 'Story with Random words',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontFamily:
                                                                              kFontFamily,
                                                                        ),
                                                                        gradient:
                                                                            greyGradient,
                                                                      ),
                                                                      leading: SizedBox(
                                                                          width: 70,
                                                                          height: 100,
                                                                          child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              child: Image.network(
                                                                                data['image'],
                                                                                fit: BoxFit.cover,
                                                                              ))),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                              ],
                                                            ),
                                                          ))
                                                      .toList(),
                                                ],
                                              )),
                                  ),
                                  if (snapshot.data!.docs.where((element) {
                                    return element['uuid'] ==
                                        AuthController.instance.getCurretUId();
                                  }).isEmpty)
                                    NeumorphismContainer(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: GradientText(
                                                    'You do not have any stories yet. Tab New story to start writing.',
                                                    gradient: greyGradient)),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(
                                              Icons.tag_faces_outlined,
                                              color: Colors.pink,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ),

                            //-------------------------------all stories----------------------->

                            if (controller.selectedTab.value != 2)
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 15),
                                        child: !snapshot.hasData
                                            ? GradientText('Loading ... ',
                                                gradient: greenGradient)
                                            : Column(
                                                children: [
                                                  ...List.generate(
                                                      snapshot
                                                          .data!.docs.length,
                                                      (index) => InkWell(
                                                            onTap: () {
                                                              debugPrint(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .data
                                                                  .toString());
                                                              controller.selectStory(
                                                                  snapshot.data!
                                                                          .docs[
                                                                      index]);
                                                              Get.to(StoryDetails());
                                                            },
                                                            child: Column(
                                                              children: [
                                                                NeumorphismContainer(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            8.0,
                                                                        vertical:
                                                                            10),
                                                                    child:
                                                                        ListTile(
                                                                      title:
                                                                          GradientText(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]['title'],
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: kFontFamily,
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.w500),
                                                                        gradient:
                                                                            greenGradient,
                                                                      ),
                                                                      subtitle:
                                                                          GradientText(
                                                                        snapshot.data!.docs[index]['type'] == 1
                                                                            ? 'Normal story'
                                                                            : 'Story with Random words',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontFamily:
                                                                              kFontFamily,
                                                                        ),
                                                                        gradient:
                                                                            greyGradient,
                                                                      ),
                                                                      leading: SizedBox(
                                                                          width: 70,
                                                                          height: 100,
                                                                          child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              child: Image.network(
                                                                                snapshot.data!.docs[index]['image'],
                                                                                fit: BoxFit.cover,
                                                                              ))),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                  // ResponsiveText('chintu'),
                                                ],
                                              ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ));
              });
        });
  }
}
