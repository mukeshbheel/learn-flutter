import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';
import 'package:learn_flutter/Login.dart';
import 'package:learn_flutter/Profile.dart';
import 'package:learn_flutter/RandomWordStory.dart';
import 'package:learn_flutter/Setting.dart';
import 'package:learn_flutter/Utils/Constant.dart';
import 'Components/NeumorphismIcon.dart';
import 'Controller/NavigationBarController.dart';
import 'Home.dart';

class NavigationBarExample extends StatefulWidget {
  const NavigationBarExample({Key? key}) : super(key: key);

  @override
  _NavigationBarExampleState createState() => _NavigationBarExampleState();
}

class _NavigationBarExampleState extends State<NavigationBarExample> {
  NavigationBarController navigationBarController =
      Get.put(NavigationBarController());
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            backgroundColor: greyBackground,
            bottomNavigationBar: Container(
              color: Colors.transparent,
              // height: 70,
              child: NavigationBar(
                height: 50,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                destinations: [
                  NavigationDestination(
                      selectedIcon: Center(
                          child: NeumorphismIcon(
                        width: selectedIconSizeNavBarWidth,
                        hight: selectedIconSizeNavBarHeight,
                        child: const Icon(
                          Icons.home,
                          color: Colors.blue,
                        ),
                      )),
                      icon: Center(
                        child: NeumorphismIcon(
                          width: notSelectedIconSizeNavBarWidth,
                          hight: notSelectedIconSizeNavBarHeight,
                          child: const Icon(
                            Icons.home,
                            size: 15,
                          ),
                        ),
                      ),
                      label: ''),
                  NavigationDestination(
                      selectedIcon: Center(
                          child: NeumorphismIcon(
                        width: selectedIconSizeNavBarWidth,
                        hight: selectedIconSizeNavBarHeight,
                        child: const Icon(
                          Icons.settings,
                          color: Colors.blue,
                        ),
                      )),
                      icon: Center(
                          child: NeumorphismIcon(
                        width: notSelectedIconSizeNavBarWidth,
                        hight: notSelectedIconSizeNavBarHeight,
                        child: const Icon(Icons.settings, size: 15),
                      )),
                      label: ''),
                  NavigationDestination(
                      selectedIcon: Center(
                          child: NeumorphismIcon(
                        width: selectedIconSizeNavBarWidth,
                        hight: selectedIconSizeNavBarHeight,
                        child: const Icon(
                          Icons.animation,
                          color: Colors.blue,
                        ),
                      )),
                      icon: Center(
                          child: NeumorphismIcon(
                        width: notSelectedIconSizeNavBarWidth,
                        hight: notSelectedIconSizeNavBarHeight,
                        child: const Icon(Icons.animation, size: 15),
                      )),
                      label: ''),
                  NavigationDestination(
                      selectedIcon: Center(
                          child: NeumorphismIcon(
                        width: selectedIconSizeNavBarWidth,
                        hight: selectedIconSizeNavBarHeight,
                        child: const Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                      )),
                      icon: Center(
                          child: NeumorphismIcon(
                        width: notSelectedIconSizeNavBarWidth,
                        hight: notSelectedIconSizeNavBarHeight,
                        child: const Icon(Icons.person, size: 15),
                      )),
                      label: ''),
                ],
                selectedIndex: navigationBarController.currentIndex.value,
                onDestinationSelected: ((int index) => setState(() {
                      _currentIndex = index;
                      navigationBarController.currentIndex.value = index;
                    })),
              ),
            ),
            body: [
              const Home(),
              // Test(),
              AuthController.instance.isLoggedIn() ? Settings() : Login(),
              Container(
                color: Colors.amber,
                child: const Center(child: Text('profile')),
              ),
              AuthController.instance.isLoggedIn() ? Profile() : Login(),
            ][navigationBarController.currentIndex.value],
          ),
        ));
  }
}
