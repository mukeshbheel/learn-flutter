import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_flutter/Components/ResponsiveText.dart';
import 'package:learn_flutter/Utils/Global.dart';
import 'package:word_generator/word_generator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/html_parser.dart';
import './Utils/Global.dart';

import 'Components/GradientText.dart';
import 'Components/NeumorphismContainer.dart';
import 'Controller/Home_controller.dart';
import 'Utils/Constant.dart';

class RandomWordStory extends StatefulWidget {
  RandomWordStory({Key? key,}) : super(key: key);

  @override
  State<RandomWordStory> createState() => _RandomWordStoryState();
}

class _RandomWordStoryState extends State<RandomWordStory> {

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: homeController,
      builder: (homeController) {
        return Obx(() => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),

              InkWell(onTap: ()async{
                await searchWord(homeController.randomWord.value);
              },child: GradientText((homeController.randomWord.value.isEmpty ? 'Tap on Get word to Start' : homeController.randomWord.value).toUpperCase(), gradient: pinkGradient,)),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [

                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: NeumorphismContainer(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                            child: SizedBox(
                              // height: 400,
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) => blueGradient.createShader(
                                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                ),
                                child: Html(
                                    data: homeController.story.value
                                ),
                                // child: ResponsiveText(story, style: TextStyle(color: Colors.black87),),
                              ),
                            )
                        ),
                      ),
                    ),

                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: NeumorphismContainer(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                            child: SizedBox(
                              height: 250,
                              child: Column(
                                children: [
                                  NeumorphismContainer(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10,),
                                          GradientText('Title', gradient: blueGradient),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: NeumorphismContainer(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: TextField(
                                                  controller: homeController.newTitle,
                                                  decoration: const InputDecoration(
                                                      border: InputBorder.none
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),

                                  NeumorphismContainer(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: ()async{
                                          await homeController.pickImageGallery();
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 10,),
                                            GradientText('Upload Image', gradient: blueGradient),
                                            const SizedBox(width: 10,),
                                            if(homeController.file.value.path.isNotEmpty || homeController.newImage.text.isNotEmpty)
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: !homeController.file.value.path.isNotEmpty ? Image.network(homeController.newImage.text, width: 50, height: 50,) : Image.file(homeController.file.value, width: 50, height: 50,),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),

                                  Expanded(
                                    child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (bounds) => blueGradient.createShader(
                                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                      ),
                                      child: TextField(
                                        controller: homeController.newLine,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Once upon a time there was a potato ...................................',
                                          // hintStyle:
                                        ),
                                        maxLines: null, // Set this
                                        expands: true, // and this
                                        keyboardType: TextInputType.multiline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ),

                    const SizedBox(height: 40,),

                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              homeController.newStory.text = homeController.story.value;
                              homeController.addStory(context);
                            },
                            child: NeumorphismContainer(
                              width: 200,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: GradientText(
                                    homeController.isLoading.value ? 'Please wait ...' : 'Save',
                                    gradient: homeController.story.isNotEmpty ? blueGradient : greyGradient,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              homeController.getRandomWord(context);
                            },
                            child: NeumorphismContainer(
                              width: 200,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: GradientText(
                                    homeController.randomWord.value.isEmpty ? 'Get word' : 'Add Line',
                                    gradient: greyGradient,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ));
      }
    );
  }
}
