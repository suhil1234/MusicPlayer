import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/controller/PlayListController.dart';

import '../../controller/playcontroller.dart';

Future<void> ShowDialog(
    BuildContext context,
    TextEditingController textEditingController,
    PlayListController playerController) {
  ThemeData theme = Theme.of(context);
  bool isSubmet = false;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.colorScheme.secondary,
          title: const Text('Enter your PlayList Name'),
          content: Obx(() {
            return TextField(
              controller: textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: "PlayList Name",
                  errorText: playerController.DialogSubmited.value
                      ? "Enter A Valid Name"
                      : null),
            );
          }),
          actions: [
            ElevatedButton(
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor),
                onPressed: () {
                  if (textEditingController.text.isNotEmpty) {
                    playerController.createplayList(textEditingController.text);
                    playerController.DialogSubmited.value = false;
                    textEditingController.clear();
                    Navigator.of(context).pop();
                  } else {
                    playerController.DialogSubmited.value = true;
                  }
                }),
            ElevatedButton(
              // ignore: prefer_const_constructors
              style:
                  ElevatedButton.styleFrom(backgroundColor: theme.primaryColor),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                textEditingController.clear();
                playerController.DialogSubmited.value = false;
              },
            )
          ],
        );
      });
}
