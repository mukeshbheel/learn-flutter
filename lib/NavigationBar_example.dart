import 'package:flutter/material.dart';
import 'package:learn_flutter/AnimatedContainer_example.dart';
import 'package:learn_flutter/AnimatedOpacity_example.dart';
import 'package:learn_flutter/GoogleAndFacebookLogin.dart';
import 'package:learn_flutter/GoogleMapsAutocomplete.dart';
import './AnimatedBuilder_example.dart';

class NavigationBarExample extends StatefulWidget {
  const NavigationBarExample({Key? key}) : super(key: key);

  @override
  _NavigationBarExampleState createState() => _NavigationBarExampleState();
}

class _NavigationBarExampleState extends State<NavigationBarExample> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
          NavigationDestination(
              icon: Icon(Icons.animation), label: 'Animation'),
          NavigationDestination(
              icon: Icon(Icons.other_houses), label: 'Others'),
        ],
        selectedIndex: _currentIndex,
        onDestinationSelected: ((int index) => setState(() {
              _currentIndex = index;
            })),
      ),
      body: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red,
          child: const Center(child: Text('Home')),
        ),
        Container(
          color: Colors.blue,
          child: const Center(child: Text('Settings')),
        ),
        Container(
          color: Colors.amber,
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              ListTile(
                // contentPadding: EdgeInsets.all(20),
                dense: true,
                title: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: const Text('Animation Builder example')),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AnimatedBuilderExample())),
              ),
              ListTile(
                dense: true,
                title: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: const Text('Animation Container example')),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AnimatedContainerExample())),
              ),
              ListTile(
                dense: true,
                title: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: const Text('Animation Opacity example')),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AnimatedOpacityExample())),
              )
            ],
          )),
        ),
        Container(
          color: Colors.green,
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              ListTile(
                // contentPadding: EdgeInsets.all(20),
                dense: true,
                title: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: const Text('Google and facebook login')),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GoogleAndFacebookLogin())),
              ),
              ListTile(
                dense: true,
                title: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: const Text('Google maps autocomplete')),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GooleMapsAutocomplete())),
              ),
              ListTile(
                dense: true,
                title: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: const Text('Animation Opacity example')),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AnimatedOpacityExample())),
              )
            ],
          )),
        ),
      ][_currentIndex],
    );
  }
}
