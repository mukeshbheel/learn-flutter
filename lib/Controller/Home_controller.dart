import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';
import 'package:word_generator/word_generator.dart';

import '../Components/GradientText.dart';
import '../Components/NeumorphismContainer.dart';
import '../Utils/Constant.dart';
import '../Utils/Global.dart';

class HomeController extends GetxController{

  RxString randomWord = ''.obs;

  RxString story = ''.obs;

  TextEditingController newLine = TextEditingController();

  final wordGenerator = WordGenerator();

  RxInt selectedTab = 0.obs;
  RxInt selectedType = 0.obs;
  RxMap selectedStory = {}.obs;
  RxString selectedStoryId = ''.obs;

  RxBool isEditing = false.obs;
  RxBool isLoading = false.obs;

  ImagePicker imagePicker = ImagePicker();
  Rx<File> file = File('').obs;
  late RxString imageUrl = ''.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference myStories = FirebaseFirestore.instance.collection('myStories');

  TextEditingController newTitle = TextEditingController();
  TextEditingController newImage = TextEditingController();
  TextEditingController newStory = TextEditingController();

  Future<void> addStory(context) async {
      isLoading.value = true;
    // await uploadProfileImage();
    //
    //
    // if(newTitle.text.isEmpty || newStory.text.isEmpty || newImage.text.isEmpty){
    //   showSnackbar(context, 'Title, Image Link and Story can not be empty.');
    //   return;
    // }
    if(!isEditing.value){
      debugPrint('filePath : ${file.value.path}');

      if(newTitle.text.isEmpty || file.value.path.isEmpty || newStory.text.isEmpty){
        showSnackbar(context, 'Title, Image Link and Story can not be empty.');
          isLoading.value = false;
        return;
      }

      await uploadProfileImage();
      if(newImage.text.isEmpty){
        showSnackbar(context, 'Image could not be uploaded.');
          isLoading.value = false;
        return;
      }

      String uuid = await AuthController.instance.getCurretUId();
      debugPrint('uuid : $uuid');
      if(uuid.isEmpty){
        return;
      }

      myStories
          .add({
        'uuid' : uuid,
        'title': newTitle.text, // John Doe
        'image': newImage.text, // Stokes and Sons
        'story': newStory.text, //
        'type': selectedType.value,// 42
      })
          .then((value){
        print("Story Saved");
        showSnackbar(context, 'Story saved successfully.', type: 'success');
          selectedTab.value = 2;
          newTitle.text = '';
          newImage.text = '';
          newStory.text = '';
          story.value = '';
          file.value = File('');
          selectedType.value = 0;
          newLine.text = '';

      } )
          .catchError((error) => showSnackbar(Get.context, 'Failed to save story: $error',));

        isLoading.value = false;
    }else{

      // // newImage.text = file.path;
      // file = File(newImage.text);

      if(newTitle.text.isEmpty || (file.value.path.isEmpty && newImage.text.isEmpty) || newStory.text.isEmpty){
        showSnackbar(context, 'Title, Image Link and Story can not be empty.');
          isLoading.value = false;
        return;
      }

      if(file.value.path.isNotEmpty) {
        await uploadProfileImage();
      }
      if(newImage.text.isEmpty){
        showSnackbar(context, 'Image could not be uploaded.');
          isLoading.value = false;
        return;
      }

      var collection = FirebaseFirestore.instance.collection('myStories');
      print('story id : ${selectedStoryId.value}');

      collection
          .doc(selectedStoryId.value)
          .update({
        'title': newTitle.text, // John Doe
        'image': newImage.text, // Stokes and Sons
        'story': newStory.text,
        'type': selectedStory.value['type'],// 42
      }) // <-- Updated data
          .then((_) async {
        print('Success');
        showSnackbar(context, 'Story updated successfully.', type: 'success');
        var updatedStory = (await getSingleStory(selectedStoryId.value)).data();
          isEditing.value = false;
          selectedTab.value = 2;
          selectedType.value = 0;
          selectedStory.value = updatedStory;
          file.value = File('');
      })
          .catchError((error) => showSnackbar(context, 'Failed to update story: $error',));

        isLoading.value = false;
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

  Future<void> deleteStory(story,) async{
    showDialog(
      context: Get.context!,
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
                        selectedStory.value = {};
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
        file.value = File(image.path);
    }
  }

  uploadProfileImage() async {
    newImage.text = '';

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child("${file.value.path.split('/').last}");

// Create a reference to 'images/mountains.jpg'
    final mountainImagesRef = storageRef.child("images/${file.value.path.split('/').last}");

    UploadTask uploadTask = mountainImagesRef.putFile(file.value);
    TaskSnapshot snapshot = await uploadTask;
    imageUrl.value = await snapshot.ref.getDownloadURL();
    print(imageUrl.value);
    newImage.text = imageUrl.value;
  }

  selectTab(tab){
      selectedTab.value == tab ? selectedTab.value = 0 :
      selectedTab.value = tab;
      selectedStory.value = {};
      isEditing.value = false;
      newStory.text = '';
      newImage.text = '';
      newTitle.text = '';
      selectedType.value = 0;
      story.value = '';
      newLine.text = '';
  }

  selectType(type){
      selectedType.value == type ? selectedTab.value = 0 :
      selectedType.value = type;
      // selectedStory = null;
      // isEditing = false;
      // newStory.text = '';
      // newImage.text = '';
      // newTitle.text = '';
  }

  selectStory(story){
    if(story == null){
      selectedStory.value = {};
      selectedStoryId.value = '';
    }else{

      selectedStoryId.value = story.id;
      debugPrint('selected story id : ${selectedStoryId}');
      // selectedTab == tab ? selectedTab = 0 :
      selectedStory.value = story.data();
      // selectedStoryId.value = story['id'];
    }

  }

  getTitle(){
    switch(selectedTab.value){
      case 1:
        return isEditing.value ? 'Editing the Story...' : 'Writing a Story...';
      case 2:
        return 'Looking at my stories...';
      default:
        return 'All Stories';
    }
  }

  getGradient(){
    switch(selectedTab.value){
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
    if(selectedStory['type'] == 2) {
      story.value = selectedStory['story'];
    }
      isEditing.value = true;
      selectedTab.value = 1;
      selectedType.value = 1;
      // var data = await selectedStory.data;
      // debugPrint(selectedStory['type'].toString());
      selectedType.value = selectedStory['type'];
      // if(selectedStory.data.type == null){

      // }
  }

  getRandomWord(context){
    if(randomWord.isEmpty) {
        randomWord.value = Random().nextBool() ? wordGenerator.randomVerb() : wordGenerator.randomNoun();
    }else{
      if(newLine.text.contains(randomWord)){
          story.value = story.value + ' ' + newLine.text.replaceAll(randomWord, '<b>$randomWord</b>');
          randomWord.value = Random().nextBool() ? wordGenerator.randomVerb() : wordGenerator.randomNoun();
          newLine.text = '';
      }else{
        showSnackbar(context, 'Please use the given word in your paragraph or sentence. Tap on the word to see the meaning.');
      }
    }


  }

}