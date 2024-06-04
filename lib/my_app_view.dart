import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/Home.dart';
import 'package:learn_flutter/Login.dart';
import 'package:learn_flutter/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:learn_flutter/screens/auth/welcome.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Easy Write",
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return Home();
          } else {
            return WelcomeScreen();
          }
          return Container();
        },
      ),
    );
  }
}
