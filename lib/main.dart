import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';
import 'package:user_repository/user_repositiory.dart';
import './NavigationBar_example.dart';
import 'package:firebase_core/firebase_core.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    // debugPrint('main');
    // Get.put(AuthController());
  });
  runApp(MyApp(FirebaseUserRepo()));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const NavigationBarExample(),
//       // home: AnimatedBuilderExample(),
//     );
//   }
// }
