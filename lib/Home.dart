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

  int selectedTab = 0;
  var selectedStory;

  bool isEditing = false;
  bool isLoading = false;

  ImagePicker imagePicker = ImagePicker();
  File file = File('');
  late String imageUrl;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference myStories = FirebaseFirestore.instance.collection('myStories');

  TextEditingController newTitle = TextEditingController();
  TextEditingController newImage = TextEditingController();
  TextEditingController newStory = TextEditingController();

  Future<void> addStory(context) async {
    setState(() {
      isLoading = true;
    });

    // await uploadProfileImage();
    //
    //
    // if(newTitle.text.isEmpty || newStory.text.isEmpty || newImage.text.isEmpty){
    //   showSnackbar(context, 'Title, Image Link and Story can not be empty.');
    //   return;
    // }
    if(!isEditing){
      debugPrint('filePath : ${file.path}');

      if(newTitle.text.isEmpty || file.path.isEmpty || newStory.text.isEmpty){
        showSnackbar(context, 'Title, Image Link and Story can not be empty.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      await uploadProfileImage();
      if(newImage.text.isEmpty){
        showSnackbar(context, 'Image could not be uploaded.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      myStories
          .add({
        'title': newTitle.text, // John Doe
        'image': newImage.text, // Stokes and Sons
        'story': newStory.text, // 42
      })
          .then((value){
        print("Story Saved");
        showSnackbar(context, 'Story saved successfully.', type: 'success');
        setState(() {
          selectedTab = 2;
          newTitle.text = '';
          newImage.text = '';
          newStory.text = '';
          file = File('');
        });

      } )
          .catchError((error) => showSnackbar(context, 'Failed to save story: $error',));

      setState(() {
        isLoading = false;
      });
    }else{

      // // newImage.text = file.path;
      // file = File(newImage.text);

      if(newTitle.text.isEmpty || (file.path.isEmpty && newImage.text.isEmpty) || newImage.text.isEmpty){
        showSnackbar(context, 'Title, Image Link and Story can not be empty.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      if(file.path.isNotEmpty) {
        await uploadProfileImage();
      }
      if(newImage.text.isEmpty){
        showSnackbar(context, 'Image could not be uploaded.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      var collection = FirebaseFirestore.instance.collection('myStories');
      print('story id : ${selectedStory.id}');

      collection
          .doc(selectedStory.id)
          .update({
        'title': newTitle.text, // John Doe
        'image': newImage.text, // Stokes and Sons
        'story': newStory.text, // 42
      }) // <-- Updated data
          .then((_) async {
            print('Success');
            showSnackbar(context, 'Story updated successfully.', type: 'success');
            var updatedStory = await getSingleStory(selectedStory.id);
            setState(() {
              isEditing = false;
              selectedTab = 2;
              selectedStory = updatedStory;
              file = File('');
            });
          })
          .catchError((error) => showSnackbar(context, 'Failed to update story: $error',));

      setState(() {
        isLoading = false;
      });
    }
  }

  Future getSingleStory(storyId) async{
    var collection = FirebaseFirestore.instance.collection('myStories');
    var docSnapshot = await collection.doc(storyId).get();
    if (docSnapshot.exists) {
      return docSnapshot;
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['some_field']; // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  Future<void> deleteStory(story) async{

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  Center(
          child: AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            backgroundColor: Colors.grey[300],
            title: GradientText("Deleting this story...",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: kFontFamily), gradient: redGradient,),
            content: GradientText("Are you sure ?", gradient: greyGradient, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: kFontFamily),),
            actions: [
              NeumorphismContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                  child: TextButton(
                    child: GradientText("Yes",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: kFontFamily), gradient: redGradient,),
                    onPressed:  () async {
                      await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                        await myTransaction.delete(story.reference);
                      });
                      setState(() {
                        selectedStory = null;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              NeumorphismContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, ),
                  child: TextButton(
                    child: GradientText("No",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: kFontFamily), gradient: redGradient,),
                    onPressed:  () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );



  }

  Future pickImageGallery() async {
    debugPrint('haalo');
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print('image file : ${image.path}');
      setState(() {
        file = File(image.path);
      });
    }
  }

  uploadProfileImage() async {
    newImage.text = '';

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child("${file.path.split('/').last}");

// Create a reference to 'images/mountains.jpg'
    final mountainImagesRef = storageRef.child("images/${file.path.split('/').last}");

    UploadTask uploadTask = mountainImagesRef.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();
    print(imageUrl);
    newImage.text = imageUrl;
  }

  selectTab(tab){
    setState(() {
      selectedTab == tab ? selectedTab = 0 :
      selectedTab = tab;
      selectedStory = null;
      isEditing = false;
      newStory.text = '';
      newImage.text = '';
      newTitle.text = '';
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
        return isEditing ? 'Editing the Story...' : 'Writing a Story...';
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

  editing(){
    newTitle.text = selectedStory['title'];
    newImage.text = selectedStory['image'];
    newStory.text = selectedStory['story'];
    setState(() {
      isEditing = true;
      selectedTab = 1;
    });
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
                                      child: InkWell(
                                        onTap: ()async{
                                          await pickImageGallery();
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 10,),
                                            GradientText('Upload Image', gradient: blueGradient),
                                            const SizedBox(width: 10,),
                                            if(file.path.isNotEmpty || newImage.text.isNotEmpty)
                                            Expanded(
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: !file.path.isNotEmpty ? Image.network(newImage.text, width: 50, height: 50,) : Image.file(file, width: 50, height: 50,),
                                                  // child: TextField(
                                                  //   controller: newImage,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: ()async{
                                            addStory(context);
                                          },
                                          child: NeumorphismContainer(
                                            width: 200,
                                            height: 40,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Center(child:
                                              GradientText(
                                                '${isLoading ? 'Please wait...' : (isEditing ? 'Update' : 'Save it now')}',
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
                                      ),
                                      const SizedBox(width: 20,),
                                      Expanded(
                                        child: InkWell(
                                          onTap: ()async{
                                            if(isEditing){
                                              setState(() {
                                                isEditing = false;
                                                selectedTab = 2;
                                              });
                                            }else{
                                              selectTab(0);
                                            }

                                          },
                                          child: NeumorphismContainer(
                                            width: 200,
                                            height: 40,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
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

                if(selectedTab == 2  && selectedStory != null)
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
                                        ),),

                                        const SizedBox(height: 20,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: (){
                                                  editing();
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
                                                  deleteStory(selectedStory);
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
