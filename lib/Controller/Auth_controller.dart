import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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
      Get.offAll(()=>const NavigationBarExample());
    }
  }

  void register(String email, String password, String confirmPassword) async{

    if(password.isEmpty || confirmPassword.isEmpty || email.isEmpty){
      showSnackbar(Get.context, 'All Fields are required');
      return;
    }

    if(password != confirmPassword){
      showSnackbar(Get.context, 'Password and confirmPassword should be same');
      return;
    }

    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on Exception catch(e){
      showSnackbar(Get.context , e.toString());
    }catch(e){
      showSnackbar(Get.context , e.toString());
    }
  }

  void login(String email, String password,) async{

    if(password.isEmpty || email.isEmpty){
      showSnackbar(Get.context, 'All Fields are required');
      return;
    }

    try{
     await auth.signInWithEmailAndPassword(email: email, password: password);
    }on Exception catch(e){
      showSnackbar(Get.context , e.toString());
    }catch(e){
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

  getCurretUId() {
      return uuid.value;
  }

  isLoggedIn() {
    return uuid.value.isNotEmpty;
  }


  // Future<bool> isLoggedIn()async{
  //   return _user.value != null;
  // }

}