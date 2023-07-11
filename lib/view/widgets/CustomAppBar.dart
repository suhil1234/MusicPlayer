// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/SearchPage.dart';

import '../Settings.dart';

class customAppBar extends StatelessWidget with PreferredSizeWidget {
  final String text;
  const customAppBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // ignore: prefer_const_constructors
      title: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(SearchPage());
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ))
      ],
      leading: IconButton(
          onPressed: () {
            Get.to(Settings());
          },
          icon: Icon(Icons.settings, color: Colors.white)),
    );
  }

  @override
  // ignore: todo
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
