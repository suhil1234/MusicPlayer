import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../view/widgets/SmallPlayer.dart';
import '../view/LandingPage.dart';
import 'constants/constants.dart';
import '../view/favoriteScreen.dart';
import '../view/widgets/CustomAppBar.dart';

import '../controller/NavigationController.dart';
import '../controller/playcontroller.dart';
import 'PlayListsPage.dart';
import 'PlayerScreen.dart';
import 'SongsPage.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationController controller = Get.put(NavigationController());
  playontroller playerController = Get.put(playontroller());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: background(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: IndexedStack(
            index: controller.tabIndex.value,
            children: const [
              LandingPage(),
              SongPage(),
              PlayListsPage(),
              favoriteScreen()
            ],
          )),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            //selectedItemColor: Theme.of(context).primaryColor,
            //unselectedItemColor: Theme.of(context).splashColor,
            currentIndex: controller.tabIndex.value,
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.music_note), label: 'music'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_add_outlined), label: 'playlists'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_rounded), label: 'favorite')
            ],
          ),
          persistentFooterButtons: [
            Visibility(
                visible:
                    playerController.smallPlayerVisibilty.value ? true : false,
                child: smallPlayer())
          ],
        ),
      );
    });
  }
}
