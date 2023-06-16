import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'Components/AuthComponent.dart';
import 'Components/GradientText.dart';
import 'Components/LoaderButton.dart';
import 'Components/NeumorphismContainer.dart';
import 'Controller/Auth_controller.dart';
import 'Utils/Constant.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController name = TextEditingController(text: AuthController.instance.getCurrentName() != 'null' ? AuthController.instance.getCurrentName()  : '');
  File file = File('');

  get selectedTab => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            InkWell(
              onTap: ()async{
                var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  print('image file : ${image.path}');
                  setState(() {
                    file = File(image.path);
                  });
                }
              },
              child: NeumorphismContainer(
                borderRadius: 60,
                child: ClipRRect( borderRadius: BorderRadius.circular(60), child: file.path.isNotEmpty ? Image.file(file, width: 80, height: 80, fit: BoxFit.cover,) : Image.network(AuthController.instance.getCurrentProfilePic() != 'null' ? AuthController.instance.getCurrentProfilePic()  : 'https://latestforyouth.com/wp-content/uploads/2022/01/Funny-Whatsapp-DP-Pictures-012201.jpg', width: 80, height: 80, fit: BoxFit.cover,)),
              ),
            ),

            const SizedBox(height: 30,),
            AuthComponent(controller: name, text: 'Name',),

            const SizedBox(height: 40,),
            Obx(() => SizedBox(
              child: NeumorphismContainer(
                child: GestureDetector(
                  onTap: (){
                    AuthController.instance.editProfile(file: file, name: name.text);
                    // if(selectedTab == 1){
                    //   AuthController.instance.register(email.text.trim(), password.text.trim(), confirmPassword.text.trim(), name.text.trim());
                    // }else{
                    //   AuthController.instance.login(email.text.trim(), password.text.trim());
                    // }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child:   AuthController.instance.loading.value ? LoaderButton()
                        : GradientText( 'Update', gradient: pinkGradient,),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
