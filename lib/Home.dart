import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_flutter/Components/GradientText.dart';
import 'package:learn_flutter/Components/NeumorphismContainer.dart';
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

  int selectedTab = 2;
  var selectedStory;

  ImagePicker imagePicker = ImagePicker();
  File file = File('');
  late String imageUrl;

  Future pickImageGallery() async {
    debugPrint('haalo');
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    }
  }

  uploadProfileImage() async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('profileImage/${file.path.split('/').last}');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();
    print(imageUrl);
    newImage.text = imageUrl;
  }

  LinearGradient greenGradient = const LinearGradient(colors: [Colors.green, Colors.black]);
  LinearGradient blueGradient = const LinearGradient(colors: [Colors.blue, Colors.black]);
  LinearGradient pinkGradient = const LinearGradient(colors: [Colors.pink, Colors.black]);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference myStories = FirebaseFirestore.instance.collection('myStories');

  TextEditingController newTitle = TextEditingController();
  TextEditingController newImage = TextEditingController();
  TextEditingController newStory = TextEditingController();

  // List myStories = [
  //   {
  //     'id'    : 1,
  //     'title' : 'The Little Boy and The Forest',
  //     'image' : 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/short-story-thumbnail-design-template-c8d3daba0e4410fb1f3d7876bb2796b3_screen.jpg?ts=1589979453',
  //     'story' : 'Nothing to show yet',
  //   },
  //   {
  //     'id'    : 2,
  //     'title' : 'Kitty Monkey',
  //     'image' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC3DFqG2AOLKS6MgUPqlSra5QAXV4etTDy4Q&usqp=CAU',
  //     'story' : 'Nothing to show yet',
  //   },
  //   {
  //     'id'    : 3,
  //     'title' : 'An Unknown letter',
  //     'image' : 'https://cdn.trendhunterstatic.com/phpthumbnails/241/241101/241101_1_800.jpeg',
  //     'story' : "A practical joker, knowing what he had done, waited until he was asleep, then removed the gourd and tied it around his own leg. He, too lay down on the caravanserai floor to sleep. The fool woke first, and saw the gourd. At first he thought that this other man must be him. Then he attacked the other, shouting: ‘If you are me: then who, for heaven’s sake, who and where am I?",
  //   },
  // ];

  Future<void> addStory() async {
    if(newTitle.text.isEmpty || newStory.text.isEmpty || newImage.text.isEmpty){
      showSnackbar(context, 'Title, Image Link and Story can not be empty.');
      return;
    }

    // Call the user's CollectionReference to add a new user
    myStories
        .add({
      'title': newTitle.text, // John Doe
      'image': newImage.text, // Stokes and Sons
      'story': newStory.text, // 42
    })
        .then((value){
      print("Story Saved");
      showSnackbar(context, 'Story saved successfully.', type: 'success');

    } )
        .catchError((error) => showSnackbar(context, 'Failed to save story: $error',));
  }

  selectTab(tab){
    setState(() {
      selectedTab == tab ? selectedTab = 0 :
      selectedTab = tab;
      selectedStory = null;
    });
  }

  selectStory(story){
    setState(() {
      // selectedTab == tab ? selectedTab = 0 :
      selectedStory = story;
    });
  }

  getTitle(){
    switch(selectedTab){
      case 1:
        return 'Writing a Story...';
      case 2:
        return 'Looking at my stories...';
      default:
        return 'Choose one of the options';
    }
  }

  getGradient(){
    switch(selectedTab){
      case 1:
        return const LinearGradient(colors: [Colors.blue, Colors.black]);
      case 2:
        return const LinearGradient(colors: [Colors.green, Colors.black]);
      default:
        return const LinearGradient(colors: [Colors.pink, Colors.black]);
    }
  }

  Widget storyDetails(){
    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('myStories').snapshots(),
      builder: (context, snapshot) {
        // if(!snapshot.hasData) return GradientText('Loading ... ', gradient: greenGradient);
        // log(snapshot.data!.docs.toString());
        return SingleChildScrollView(
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
                            selectTab(1);
                          },
                          child: Center(
                            child: NeumorphismContainer(
                                borderRadius: 12,
                                height: 150,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      selectedTab == 1 ?
                                      const Icon(Icons.reply, color: Colors.blue, size: 30,)
                                      :
                                  const Icon(Icons.create, color: Colors.blue, size: 30,),

                                      const SizedBox(height: 15,),
                                      GradientText(
                                        selectedTab == 1 ? 'Go back' : 'New Story',
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
                            selectTab(2);
                          },
                          child: Center(
                            child: NeumorphismContainer(
                                borderRadius: 12,
                                height: 150,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      selectedTab == 2 ?
                                      const Icon(Icons.reply, color: Colors.green, size: 30,)
                                          :
                                      const Icon(Icons.museum, color: Colors.green, size: 30,),
                                      const SizedBox(height: 15,),
                                      GradientText(
                                        selectedTab == 2 ? 'Go back' : 'Your Stories',
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
                    child: GradientText('${getTitle()}', gradient: getGradient(), style: const TextStyle(fontWeight: FontWeight.w600, ),),
                  ),
                ),

                //----------------------------------------section 4-------------------
                if(selectedTab == 1)
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
                              height: 400,
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
                                                  controller: newTitle,
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
                                      // child: InkWell(
                                      //   onTap: ()async{
                                      //     await pickImageGallery();
                                      //     if(file.path.isNotEmpty){
                                      //       uploadProfileImage();
                                      //     }
                                      //   },
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10,),
                                            GradientText('Image Link', gradient: blueGradient),
                                            const SizedBox(width: 10,),
                                            Expanded(
                                              child: NeumorphismContainer(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: TextField(
                                                    controller: newImage,
                                                    // readOnly: true,
                                                    decoration: const InputDecoration(
                                                        border: InputBorder.none
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      // ),
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
                                        controller: newStory,
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
                                  const SizedBox(height: 10,),
                                  InkWell(
                                    onTap: ()async{
                                      addStory();
                                    },
                                    child: NeumorphismContainer(
                                      width: 200,
                                      height: 40,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(child:
                                        GradientText(
                                          'Save it now',
                                          gradient: LinearGradient(
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
                                  const SizedBox(height: 10,),
                                ],
                              ),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if(selectedTab == 2 && selectedStory == null)
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
                                        selectStory(snapshot.data!.docs[index]);
                                      },
                                      child: Column(
                                        children: [
                                          NeumorphismContainer(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical:  10),
                                              child: ListTile(
                                                title: GradientText(snapshot.data!.docs[index]['title'], style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: kFontFamily
                                                ),
                                                  gradient: greenGradient,

                                                ),
                                                // title: ResponsiveText('The Little Boy and The Forest', style: TextStyle(
                                                //   color: Colors.black,
                                                //   fontFamily: kFontFamily
                                                // ),),
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

                if(selectedStory != null)
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
                                            child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(selectedStory['image'], fit: BoxFit.cover,)),
                                        ),
                                        const SizedBox(height: 20,),
                                        GradientText(selectedStory['title'], gradient: greenGradient, style: TextStyle(
                                          fontFamily: kFontFamily,
                                          color: Colors.black87,
                                          letterSpacing: 1,
                                          wordSpacing: 3,
                                          height: 2,
                                        ),),
                                        const SizedBox(height: 20,),
                                        ResponsiveText(selectedStory['story'], style: TextStyle(
                                          fontFamily: kFontFamily,
                                          color: Colors.black87,
                                          letterSpacing: 1,
                                          wordSpacing: 3,
                                          height: 2,
                                        ),)
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
                                  selectStory(null);
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
        );
      }
    );
  }
}
