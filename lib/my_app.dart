import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:learn_flutter/my_app_view.dart';
import 'package:user_repository/user_repositiory.dart';

class MyApp extends StatelessWidget {
  MyApp(this.userRepository, {Key? key}) : super(key: key);

  UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: MyAppView(),
    );
  }
}
