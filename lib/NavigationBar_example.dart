import 'package:flutter/material.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';
import 'package:learn_flutter/Login.dart';
import 'package:learn_flutter/Profile.dart';
import 'package:learn_flutter/RandomWordStory.dart';
import 'Components/NeumorphismIcon.dart';
import 'Home.dart';

class NavigationBarExample extends StatefulWidget {
  const NavigationBarExample({Key? key}) : super(key: key);

  @override
  _NavigationBarExampleState createState() => _NavigationBarExampleState();
}

class _NavigationBarExampleState extends State<NavigationBarExample> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        bottomNavigationBar: Container(
        color: Colors.transparent,
          height: 70,
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            destinations:  [
              NavigationDestination(
                  selectedIcon: Center(child: NeumorphismIcon( child: const Icon(Icons.home, color: Colors.blue,),)),
                  icon: Center(child: NeumorphismIcon( child: const Icon(Icons.home),),), label: ''),
              NavigationDestination(
                  selectedIcon: Center(child: NeumorphismIcon( child: const Icon(Icons.settings, color: Colors.blue,),)),
                  icon: Center(child: NeumorphismIcon( child: const Icon(Icons.settings),)), label: ''),
              NavigationDestination(
                selectedIcon: Center(child: NeumorphismIcon( child: const Icon(Icons.animation, color: Colors.blue,),)),
                  icon: Center(child: NeumorphismIcon( child: const Icon(Icons.animation),)), label: ''),
              NavigationDestination(
                  selectedIcon: Center(child: NeumorphismIcon( child: const Icon(Icons.person, color: Colors.blue,),)),
                  icon: Center(child: NeumorphismIcon( child: const Icon(Icons.person),)), label: ''),
            ],
            selectedIndex: _currentIndex,
            onDestinationSelected: ((int index) => setState(() {
                  _currentIndex = index;
                })),
          ),
        ),
        body: [
          const Home(),
          // Test(),
          Container(
            color: Colors.amber,
            child: const Center(child: Text('profile')),
          ),
          Container(
            color: Colors.amber,
            child: const Center(child: Text('profile')),
          ),
          AuthController.instance.isLoggedIn()?
          Profile() : Login(),
        ][_currentIndex],
      ),
    );
  }
}
