import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class GoogleAndFacebookLogin extends StatefulWidget {
  const GoogleAndFacebookLogin({Key? key}) : super(key: key);

  @override
  State<GoogleAndFacebookLogin> createState() => _GoogleAndFacebookLoginState();
}

class _GoogleAndFacebookLoginState extends State<GoogleAndFacebookLogin> {
  bool isSignedIn = false;
  String email = '';
  late String name;
  late String image;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn();
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   setState(() {
    //     _currentUser = account;
    //   });
    //   if (_currentUser != null) {
    //     _handleGetContact(_currentUser!);
    //   }
    // });
    // _googleSignIn.signInSilently();
  }

  // login with google using firebase

  Future<void> signUp() async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      log('$googleSignInAccount');
      // log(googleSignInAccount.authHeaders)
      setState(() {
        isSignedIn = true;
        email = googleSignInAccount.email;
        image = googleSignInAccount.photoUrl!;
        name = googleSignInAccount.displayName!;
      });
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      log('${googleSignInAuthentication.accessToken}');
      // UserCredential result = await auth.signInWithCredential(authCredential);
      // log('result is : $result');
      // // User? user = result.user;
      // log('user ldjf');

      // if (result != null) {
      //   log('is result');
      //   setState(() {
      //     isSignedIn = true;
      //   });
      // }
      // log('$result');
    } else {
      log('something went wrong!!! : $googleSignInAccount');
    }
  }

  // google sign out
  Future<void> signOut() async {
    _googleSignIn.disconnect();
    setState(() {
      isSignedIn = false;
    });
  }

// login with facebook
  Future<void> facebookLogin() async {
    // await FacebookAuth.instance
    //     .login(permissions: ['public_profile', 'email']).then((value) {
    //   log(value.toString());
    //   log('${value.status}');

    //   // FacebookAuth.instance.getUserData().then((userData) {
    //   //   log('$userData');
    //   // setState(() {
    //   //   isSignedIn = true;
    //   //   email =
    //   // });
    //   // });
    // });
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: [
          'public_profile',
          'email',
          'pages_show_list',
          'pages_messaging',
          'pages_manage_metadata'
        ],
      ); // by default we request the email and the public profile
// or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result.accessToken!;
      } else {
        print('status : ${result.status}');
        print('message : ${result.message}');
      }
      // final _instance = FacebookAuth.instance;
      // final result = await _instance.login(
      //     permissions: ['email'],
      //     loginBehavior: LoginBehavior.nativeWithFallback);
      // if (result.status == LoginStatus.success) {
      //   final OAuthCredential credential =
      //       FacebookAuthProvider.credential(result.accessToken!.token);
      //   final a = await auth.signInWithCredential(credential);
      //   await _instance.getUserData().then((userData) async {
      //     await auth.currentUser!.updateEmail(userData['email']);
      //   });
      //   return null;
      // } else if (result.status == LoginStatus.cancelled) {
      //   log('Login cancelled');
      // } else {
      //   log('Error : ${result.status}');
      // }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google and facebook login'),
      ),
      body: Center(
        child: isSignedIn
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(image),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(email),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: const Text('Sign out'),
                    onPressed: () {
                      signOut();
                    },
                  ),
                ],
              )
            : Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    child: const Text('Sign in with Google using firebase'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      facebookLogin();
                    },
                    child: const Text('Sign in with Facebook'),
                  ),
                ],
              ),
      ),
    );
  }
}
