import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/Controller/Home_controller.dart';
import 'package:learn_flutter/Home.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/NavigationBar_example.dart';

import '../Login.dart';
import '../Utils/Global.dart';

class AuthController extends GetxController{

  static AuthController instance = Get.find<AuthController>();

  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxString uuid = ''.obs;
  RxString name = ''.obs;
  RxString imageUrl = ''.obs;


  RxBool loading = false.obs;

  @override
  void onReady(){

    super.onReady();
    debugPrint('haalo');
    _user = Rx<User?>(auth.currentUser);
    
    _user.bindStream(auth.userChanges());

    ever(_user, _initialScreen);
  }

  _initialScreen(User? user){
    debugPrint('user : $user');
    if(user == null){
      uuid.value = '';
      Get.offAll(() => Login(selectedTab: 0,));
    }else{
      uuid.value = user.uid;
      name.value = user.displayName ?? '';
      imageUrl.value = user.photoURL ?? '';
      if(Get.isRegistered<HomeController>() == false)
      Get.offAll(()=>const NavigationBarExample());
    }
  }

  void register(String email, String password, String confirmPassword, String name) async{

    if(password.isEmpty || confirmPassword.isEmpty || email.isEmpty || name.isEmpty){
      showSnackbar(Get.context, 'All Fields are required');
      return;
    }

    if(password != confirmPassword){
      showSnackbar(Get.context, 'Password and confirmPassword should be same');
      return;
    }

    try{

      loading.value = true;
      var result  = await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        // UserUpdateInfo updateInfo = UserUpdateInfo();
        updateProfile(updateType: 'name', value: name);
      });
      loading.value = false;
    }on Exception catch(e){
      loading.value = false;
      showSnackbar(Get.context , e.toString());
    }catch(e){
      loading.value = false;
      showSnackbar(Get.context , e.toString());
    }
  }

  void login(String email, String password,) async{

    if(password.isEmpty || email.isEmpty){
      showSnackbar(Get.context, 'All Fields are required');
      return;
    }

    try{
      loading.value = true;
     await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.to(()=>const NavigationBarExample());
      loading.value = false;
    }on Exception catch(e){
      loading.value = false;
      showSnackbar(Get.context , e.toString());
    }catch(e){
      loading.value = false;
      showSnackbar(Get.context , e.toString());
    }
  }

  void logout() async{
    try{
      await auth.signOut();
    }on Exception catch(e){
      showSnackbar(Get.context , e.toString());
    }catch(e){
      showSnackbar(Get.context , e.toString());
    }
  }

  void updateProfile({required String updateType, required value }) async{

    switch(updateType){
      case 'name' :
        try{
        auth.currentUser!.updateDisplayName(value);
    }on Exception catch(e){
      showSnackbar(Get.context , e.toString());
    }catch(e){
      showSnackbar(Get.context , e.toString());
    }
        break;

      case 'image' :
        try{
        auth.currentUser!.updatePhotoURL(value);
    }on Exception catch(e){
      showSnackbar(Get.context , e.toString());
    }catch(e){
      showSnackbar(Get.context , e.toString());
    }
        break;

      case 'phone' :
        try{
        auth.currentUser!.updatePhoneNumber(value);
    }on Exception catch(e){
      showSnackbar(Get.context , e.toString());
    }catch(e){
      showSnackbar(Get.context , e.toString());
    }
        break;

      default :
        return;
    }
  }

  String getCurrentName(){
    if(auth.currentUser != null){
      return auth.currentUser!.displayName.toString();
    }else{
      return 'user name';
    }
  }

  String getCurrentProfilePic(){
    if(auth.currentUser != null){
      return auth.currentUser!.photoURL.toString();
    }else{
      return '';
    }
  }

  getCurretUId() {
      return uuid.value;
  }

  isLoggedIn() {
    return uuid.value.isNotEmpty;
  }

  uploadProfileImage(file) async {
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child("${file.path.split('/').last}");

// Create a reference to 'images/mountains.jpg'
    final mountainImagesRef =
    storageRef.child("images/${file.path.split('/').last}");

    UploadTask uploadTask = mountainImagesRef.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();

  }

  editProfile({required File file, required String name })async{
    loading.value = true;
    if(file.path.isNotEmpty){
      var imageUrl = await uploadProfileImage(file);
      updateProfile(updateType: 'image', value: imageUrl);
    }

    if(name.isNotEmpty){
      updateProfile(updateType: 'name', value: name);
    }
    loading.value = false;
    Get.back();
  }


  // Future<bool> isLoggedIn()async{
  //   return _user.value != null;
  // }

}