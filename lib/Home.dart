import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_flutter/Components/GradientText.dart';
import 'package:learn_flutter/Components/NeumorphismContainer.dart';
import 'package:learn_flutter/Controller/Home_controller.dart';
import 'package:learn_flutter/RandomWordStory.dart';
import 'package:learn_flutter/Utils/Constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_flutter/Utils/Global.dart';

import 'Components/ResponsiveText.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return StreamBuilder(
            stream: controller.firestore.collection('myStories').snapshots(),
            builder: (context, snapshot) {
              // if(!snapshot.hasData) return GradientText('Loading ... ', gradient: greenGradient);
              // log(snapshot.data!.docs.toString());
              return Obx(() => SingleChildScrollView(
                child: Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 80,),
                      Center(
                        child: NeumorphismContainer(
                            borderRadius: 12,
                            height: 100,
                            width: 200,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GradientText(
                                    'Easy Write',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: kFontFamily,
                                        fontWeight: FontWeight.bold
                                    ), gradient: pinkGradient,
                                  ),
                                  const Icon(Icons.menu_book_rounded, color: Colors.pink,)
                                ],
                              ),
                            )
                        ),
                      ),

                      //-------------------------------section 2---------------------------
                      const SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  controller.selectTab(1);
                                },
                                child: Center(
                                  child: NeumorphismContainer(
                                      borderRadius: 12,
                                      height: 150,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            controller.selectedTab == 1 ?
                                            const Icon(Icons.reply, color: Colors.blue, size: 30,)
                                                :
                                            const Icon(Icons.create, color: Colors.blue, size: 30,),

                                            const SizedBox(height: 15,),
                                            GradientText(
                                              controller.selectedTab == 1 ? 'Go back' : 'New Story',
                                              style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontFamily: 'JosefinSans',
                                                  fontWeight: FontWeight.normal
                                              ),
                                              gradient: blueGradient,
                                            ),

                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  controller.selectTab(2);
                                },
                                child: Center(
                                  child: NeumorphismContainer(
                                      borderRadius: 12,
                                      height: 150,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            controller.selectedTab == 2 ?
                                            const Icon(Icons.reply, color: Colors.green, size: 30,)
                                                :
                                            const Icon(Icons.museum, color: Colors.green, size: 30,),
                                            const SizedBox(height: 15,),
                                            GradientText(
                                              controller.selectedTab == 2 ? 'Go back' : 'Your Stories',
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 16,
                                                  fontFamily: 'JosefinSans',
                                                  fontWeight: FontWeight.normal
                                              ),
                                              gradient: greenGradient,
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      //-------------------------------section 3--------------------------
                      const SizedBox(height: 50,),
                      NeumorphismContainer(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                          child: GradientText('${controller.getTitle()}', gradient: controller.getGradient(), style: const TextStyle(fontWeight: FontWeight.w600, ),),
                        ),
                      ),

                      //----------------------------------------section 4-------------------
                      if(controller.selectedTab == 1)

                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              if(!controller.isEditing.value)
                                const SizedBox(height: 20,),
                              if(!controller.isEditing.value)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      if(!controller.isEditing.value)
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                controller.selectType(1);
                                              },
                                              child: NeumorphismContainer(
                                                // height: 100,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                                                  child: GradientText(
                                                    'Write Normal Story',
                                                    gradient: blueGradient,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10,),

                                            if(controller.selectedType.value == 1)
                                              const Icon(Icons.double_arrow_sharp, color: Colors.blue,)
                                          ],
                                        ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              controller.selectType(2);
                                            },
                                            child: NeumorphismContainer(
                                              // height: 100,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                                                child: GradientText(
                                                  'Write Story with Random Words',
                                                  gradient: blueGradient,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),

                                          if(controller.selectedType.value == 2)
                                            const Icon(Icons.double_arrow_sharp, color: Colors.blue,)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),


                              if(controller.selectedType.value != 0)
                                const SizedBox(height: 20,),

                              if(controller.selectedType.value == 1)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: NeumorphismContainer(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                                        child: SizedBox(
                                          height: 500,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                                child: Row(
                                                  children: [
                                                    GradientText('Normal Story', gradient: blueGradient)
                                                  ],
                                                ),
                                              ),
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
                                                              controller: controller.newTitle,
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
                                                      await controller.pickImageGallery();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const SizedBox(width: 10,),
                                                        GradientText('Upload Image', gradient: blueGradient),
                                                        const SizedBox(width: 10,),
                                                        if(controller.file.value.path.isNotEmpty || controller.newImage.text.isNotEmpty)
                                                          Expanded(
                                                            child: Container(
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                child: !controller.file.value.path.isNotEmpty ? Image.network(controller.newImage.text, width: 50, height: 50,) : Image.file(controller.file.value, width: 50, height: 50,),
                                                                // child: TextField(
                                                                //   controller: controller.newImage,
                                                                //   readOnly: true,
                                                                //   decoration: const InputDecoration(
                                                                //       border: InputBorder.none
                                                                //   ),
                                                                // ),
                                                              ),
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
                                                    controller: controller.newStory,
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
                                              const SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: ()async{
                                                        controller.addStory(context);
                                                      },
                                                      child: NeumorphismContainer(
                                                        width: 200,
                                                        height: 40,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Center(child:
                                                          GradientText(
                                                            '${controller.isLoading.value ? 'Please wait...' : (controller.isEditing.value ? 'Update' : 'Save it now')}',
                                                            gradient: const LinearGradient(
                                                                colors: [
                                                                  Colors.blue,
                                                                  Colors.black
                                                                ]
                                                            ),
                                                          ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20,),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: ()async{
                                                        if(controller.isEditing.value){
                                                          controller.isEditing.value = false;
                                                          controller.selectedTab.value = 2;
                                                        }else{
                                                          controller.selectTab(0);
                                                        }

                                                      },
                                                      child: NeumorphismContainer(
                                                        width: 200,
                                                        height: 40,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Center(child:
                                                          GradientText(
                                                            'Cancel',
                                                            gradient: blueGradient,
                                                          ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                ),

                              if(controller.selectedType.value == 2)
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: NeumorphismContainer(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 15,),
                                            Row(
                                              children: [
                                                const SizedBox(width: 10,),
                                                GradientText('Story with Random Words', gradient: blueGradient)
                                              ],
                                            ),
                                            const SizedBox(height: 15,),
                                            RandomWordStory(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 20,
                                      child: InkWell(
                                        onTap: ()async{
                                          if(controller.isEditing.value){
                                            controller.isEditing.value = false;
                                            controller.selectedTab.value = 2;
                                          }else{
                                            controller.selectTab(0);
                                          }

                                        },
                                        child: NeumorphismContainer(
                                          width: 40,
                                          height: 40,
                                          borderRadius: 60,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(child:
                                            Icon(Icons.reply, )
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                            ],
                          ),
                        ),


                      if(controller.selectedTab.value == 2 && controller.selectedStory.isEmpty)
                        Column(
                          children: [
                            const SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                                    child: !snapshot.hasData ?
                                    GradientText('Loading ... ', gradient: greenGradient)
                                        : Column(
                                      children: [
                                        ...List.generate(
                                            snapshot.data!.docs.length, (index) =>
                                            InkWell(
                                              onTap: (){
                                                debugPrint(snapshot.data!.docs[index].data.toString());
                                                controller.selectStory(snapshot.data!.docs[index]);
                                              },
                                              child: Column(
                                                children: [
                                                  NeumorphismContainer(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical:  10),
                                                      child: ListTile(
                                                        title: GradientText(
                                                          snapshot.data!.docs[index]['title'],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: kFontFamily,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                          gradient: greenGradient,
                                                        ),
                                                        subtitle: GradientText(
                                                          snapshot.data!.docs[index]['type'] == 1 ? 'Normal story' : 'Story with Random words',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: kFontFamily,
                                                          ),
                                                          gradient: greyGradient,
                                                        ),
                                                        leading: Container( width: 70, height: 100, child:
                                                        ClipRRect(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: Image.network(snapshot.data!.docs[index]['image'], fit: BoxFit.cover,))),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),
                                                ],
                                              ),
                                            )
                                        ),
                                        // ResponsiveText('chintu'),
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),

                      if(controller.selectedTab == 2  && controller.selectedStory.isNotEmpty)
                        Column(
                          children: [
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(height: 20,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: NeumorphismContainer(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical:  10),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 20,),
                                              SizedBox(
                                                width: double.infinity*0.5,
                                                // height: 100,
                                                child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(controller.selectedStory['image'], fit: BoxFit.cover,)),
                                              ),
                                              const SizedBox(height: 20,),
                                              GradientText(controller.selectedStory['title'], gradient: greenGradient, style: TextStyle(
                                                fontFamily: kFontFamily,
                                                color: Colors.black87,
                                                letterSpacing: 1,
                                                wordSpacing: 3,
                                                height: 2,
                                              ),),
                                              const SizedBox(height: 20,),
                                              if(controller.selectedStory['type'] == 1)
                                              ResponsiveText(controller.selectedStory['story'], style: TextStyle(
                                                fontFamily: kFontFamily,
                                                color: Colors.black87,
                                                letterSpacing: 1,
                                                wordSpacing: 3,
                                                height: 2,
                                              ),),
                                              if(controller.selectedStory['type'] == 2)
                                                Html(
                                                  data: controller.selectedStory['story'],
                                                  style: {
                                                    // p tag with text_size
                                                    "body": Style(
                                                      fontSize: const FontSize(14),
                                                      fontFamily: kFontFamily,
                                                      letterSpacing: 1,
                                                      wordSpacing: 3,
                                                      lineHeight: const LineHeight(2)
                                                    ),
                                                  },
                                                ),

                                              const SizedBox(height: 20,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: (){
                                                        controller.editing();
                                                      },
                                                      child: NeumorphismContainer(
                                                        width: 200,
                                                        // height: 100,
                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                            child: GradientText(
                                                              'Edit',
                                                              gradient: greenGradient,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20,),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () async{
                                                        controller.deleteStory(controller.selectedStory, context);
                                                      },
                                                      child: NeumorphismContainer(
                                                        width: 200,
                                                        // height: 100,
                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                            child: GradientText(
                                                              'Delete',
                                                              gradient: redGradient,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
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
                                    child: IconButton(onPressed: (){
                                      controller.selectStory(null);
                                    }, icon: const Icon(Icons.reply), color: Colors.green,),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),


                      const SizedBox(height: 20,),

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
