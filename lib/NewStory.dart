import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Components/GradientText.dart';
import 'Components/NeumorphismContainer.dart';
import 'Controller/Auth_controller.dart';
import 'Controller/Home_controller.dart';
import 'RandomWordStory.dart';
import 'Utils/Constant.dart';

class NewStory extends StatefulWidget {
  const NewStory({Key? key}) : super(key: key);

  @override
  State<NewStory> createState() => _NewStoryState();
}

class _NewStoryState extends State<NewStory> {

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
                // if (controller.selectedTab == 1)
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      if (!controller.isEditing.value)
                        const SizedBox(
                          height: 20,
                        ),
                      if (!controller.isEditing.value)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              if (!controller.isEditing.value)
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.selectType(1);
                                      },
                                      child: NeumorphismContainer(
                                        // height: 100,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .symmetric(
                                              horizontal: 8.0,
                                              vertical: 10),
                                          child: GradientText(
                                            'Write Normal Story',
                                            gradient:
                                            blueGradient,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    if (controller
                                        .selectedType.value ==
                                        1)
                                      const Icon(
                                        Icons.double_arrow_sharp,
                                        color: Colors.blue,
                                      )
                                  ],
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.selectType(2);
                                    },
                                    child: NeumorphismContainer(
                                      // height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 8.0,
                                            vertical: 10),
                                        child: GradientText(
                                          'Write Story with Random Words',
                                          gradient: blueGradient,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  if (controller
                                      .selectedType.value ==
                                      2)
                                    const Icon(
                                      Icons.double_arrow_sharp,
                                      color: Colors.blue,
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (controller.selectedType.value != 0)
                        const SizedBox(
                          height: 20,
                        ),
                      if (controller.selectedType.value == 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: NeumorphismContainer(
                            child: Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 15),
                                child: SizedBox(
                                  height: 500,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            vertical: 20.0),
                                        child: Row(
                                          children: [
                                            GradientText(
                                                'Normal Story',
                                                gradient:
                                                blueGradient)
                                          ],
                                        ),
                                      ),
                                      NeumorphismContainer(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .all(8.0),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GradientText(
                                                  'Title',
                                                  gradient:
                                                  blueGradient),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child:
                                                NeumorphismContainer(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        8.0),
                                                    child:
                                                    TextField(
                                                      controller:
                                                      controller
                                                          .newTitle,
                                                      decoration:
                                                      const InputDecoration(
                                                          border:
                                                          InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      NeumorphismContainer(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .all(8.0),
                                          child: InkWell(
                                            onTap: () async {
                                              await controller
                                                  .pickImageGallery();
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                GradientText(
                                                    'Upload Image',
                                                    gradient:
                                                    blueGradient),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                if (controller
                                                    .file
                                                    .value
                                                    .path
                                                    .isNotEmpty ||
                                                    controller
                                                        .newImage
                                                        .text
                                                        .isNotEmpty)
                                                  Expanded(
                                                    child:
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          8.0),
                                                      child: !controller
                                                          .file
                                                          .value
                                                          .path
                                                          .isNotEmpty
                                                          ? Image
                                                          .network(
                                                        controller.newImage.text,
                                                        width: 50,
                                                        height: 50,
                                                      )
                                                          : Image
                                                          .file(
                                                        controller.file.value,
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                      // child: TextField(
                                                      //   controller: controller.newImage,
                                                      //   readOnly: true,
                                                      //   decoration: const InputDecoration(
                                                      //       border: InputBorder.none
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: ShaderMask(
                                          blendMode:
                                          BlendMode.srcIn,
                                          shaderCallback:
                                              (bounds) =>
                                              blueGradient
                                                  .createShader(
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height),
                                              ),
                                          child: TextField(
                                            controller: controller
                                                .newStory,
                                            decoration:
                                            const InputDecoration(
                                              border: InputBorder
                                                  .none,
                                              hintText:
                                              'Once upon a time there was a potato ...................................',
                                              // hintStyle:
                                            ),
                                            maxLines:
                                            null, // Set this
                                            expands:
                                            true, // and this
                                            keyboardType:
                                            TextInputType
                                                .multiline,
                                          ),
                                        ),

                                        // TextField(
                                        //   controller: controller.newStory,
                                        //   decoration: const InputDecoration(
                                        //     border: InputBorder.none,
                                        //     hintText: 'Start your story...',
                                        //     hintStyle:
                                        //   ),
                                        //   maxLines: null, // Set this
                                        //   expands: true, // and this
                                        //   keyboardType: TextInputType.multiline,
                                        // ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                controller
                                                    .addStory(
                                                    context);
                                              },
                                              child:
                                              NeumorphismContainer(
                                                width: 200,
                                                height: 40,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(
                                                      8.0),
                                                  child: Center(
                                                    child:
                                                    GradientText(
                                                      controller.isLoading.value ? 'Please wait...' : (controller.isEditing.value ? 'Update' : 'Save it now'),
                                                      gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                            Colors
                                                                .blue,
                                                            Colors
                                                                .black
                                                          ]),
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
                                              onTap: () async {
                                                if (controller
                                                    .isEditing
                                                    .value) {
                                                  controller
                                                      .isEditing
                                                      .value =
                                                  false;
                                                  controller
                                                      .selectedTab
                                                      .value = 2;
                                                  Get.back();
                                                } else {
                                                  controller
                                                      .selectTab(
                                                      0);
                                                }
                                              },
                                              child:
                                              NeumorphismContainer(
                                                width: 200,
                                                height: 40,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(
                                                      8.0),
                                                  child: Center(
                                                    child:
                                                    GradientText(
                                                      'Cancel',
                                                      gradient:
                                                      blueGradient,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      if (controller.selectedType.value == 2)
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: NeumorphismContainer(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GradientText(
                                            'Story with Random Words',
                                            gradient:
                                            blueGradient)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    RandomWordStory(),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 20,
                              child: InkWell(
                                onTap: () async {
                                  if (controller
                                      .isEditing.value) {
                                    controller.isEditing.value =
                                    false;
                                    // controller.selectedTab.value =
                                    // 2;
                                    Get.back();
                                  } else {
                                    controller.selectTab(0);
                                  }
                                },
                                child: NeumorphismContainer(
                                  width: 40,
                                  height: 40,
                                  borderRadius: 60,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Icon(
                                          Icons.reply,
                                        )),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    );
  }
}
