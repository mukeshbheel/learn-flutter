import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:learn_flutter/Components/ResponsiveText.dart';
import 'package:learn_flutter/Utils/Global.dart';
import 'package:word_generator/word_generator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/html_parser.dart';
import './Utils/Global.dart';

import 'Components/GradientText.dart';
import 'Components/NeumorphismContainer.dart';
import 'Utils/Constant.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  String randomWord = '';

  String story = '';

  TextEditingController newLine = TextEditingController();

  final wordGenerator = WordGenerator();

  getRandomWord(context){
    if(randomWord.isEmpty) {
      setState(() {
      randomWord = Random().nextBool() ? wordGenerator.randomVerb() : wordGenerator.randomNoun();
    });
    }else{
      if(newLine.text.contains(randomWord)){
        setState(() {
          story = story + ' ' + newLine.text.replaceAll(randomWord, '<b>$randomWord</b>');
          randomWord = Random().nextBool() ? wordGenerator.randomVerb() : wordGenerator.randomNoun();
          newLine.text = '';
        });
      }else{
        showSnackbar(context, 'Please use the given word in your paragraph or sentence. Tap on the word to see the meaning.');
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const SizedBox(height: 20,),

          InkWell(onTap: ()async{
            await searchWord(randomWord);
          },child: GradientText('${randomWord.isEmpty ? 'Tap on Get word to Start' : randomWord}'.toUpperCase(), gradient: pinkGradient,)),
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
                              data: story
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
                          height: 200,
                          child: Column(
                            children: [
                              // NeumorphismContainer(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Row(
                              //       children: [
                              //         const SizedBox(width: 10,),
                              //         GradientText('Title', gradient: blueGradient),
                              //         const SizedBox(width: 10,),
                              //         Expanded(
                              //           child: NeumorphismContainer(
                              //             child: Padding(
                              //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              //               child: TextField(
                              //                 // controller: newTitle,
                              //                 decoration: const InputDecoration(
                              //                     border: InputBorder.none
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 20,),
                              //
                              // NeumorphismContainer(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: InkWell(
                              //       onTap: ()async{
                              //         // await pickImageGallery();
                              //       },
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           const SizedBox(width: 10,),
                              //           GradientText('Upload Image', gradient: blueGradient),
                              //           const SizedBox(width: 10,),
                              //           // if(file.path.isNotEmpty || newImage.text.isNotEmpty)
                              //             Expanded(
                              //               child: Container(
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              //                   // child: !file.path.isNotEmpty ? Image.network(newImage.text, width: 50, height: 50,) : Image.file(file, width: 50, height: 50,),
                              //                   child: TextField(
                              //                     // controller: newImage,
                              //                     readOnly: true,
                              //                     decoration: const InputDecoration(
                              //                         border: InputBorder.none
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 20,),

                              Expanded(
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) => blueGradient.createShader(
                                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                  ),
                                  child: TextField(
                                    controller: newLine,
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
                                //   controller: newStory,
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
                              // const SizedBox(height: 10,),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: InkWell(
                              //         onTap: ()async{
                              //           // addStory(context);
                              //         },
                              //         child: NeumorphismContainer(
                              //           width: 200,
                              //           height: 40,
                              //           child: const Padding(
                              //             padding: EdgeInsets.all(8.0),
                              //             child: Center(child:
                              //             GradientText(
                              //               'save',
                              //               // '${isLoading ? 'Please wait...' : (isEditing ? 'Update' : 'Save it now')}',
                              //               gradient: LinearGradient(
                              //                   colors: [
                              //                     Colors.blue,
                              //                     Colors.black
                              //                   ]
                              //               ),
                              //             ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(width: 20,),
                              //     Expanded(
                              //       child: InkWell(
                              //         onTap: ()async{
                              //           // if(isEditing){
                              //           //   setState(() {
                              //           //     isEditing = false;
                              //           //     selectedTab = 2;
                              //           //   });
                              //           // }else{
                              //           //   selectTab(0);
                              //           // }
                              //
                              //         },
                              //         child: NeumorphismContainer(
                              //           width: 200,
                              //           height: 40,
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Center(child:
                              //             GradientText(
                              //               'Cancel',
                              //               gradient: blueGradient,
                              //             ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 10,),
                            ],
                          ),
                        )
                    ),
                  ),
                ),

                const SizedBox(height: 40,),

                InkWell(
                  onTap: (){
                    getRandomWord(context);
                  },
                  child: NeumorphismContainer(
                    width: 200,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: GradientText(
                          '${randomWord.isEmpty ? 'Get word' : 'Next word'}',
                          gradient: greyGradient,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
