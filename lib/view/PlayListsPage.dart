import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:prototype/controller/PlayListController.dart';
import 'package:prototype/view/widgets/CustomAppBar.dart';

import '../controller/playcontroller.dart';
import 'constants/constants.dart';
import 'widgets/PLayLists.dart';
import 'widgets/PlayListDialog.dart';

class PlayListsPage extends StatefulWidget {
  const PlayListsPage({super.key});

  @override
  State<PlayListsPage> createState() => _PlayListsPageState();
}

class _PlayListsPageState extends State<PlayListsPage> {
  late TextEditingController textEditingController;
  PlayListController playerController = Get.put(PlayListController());
  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const customAppBar(
        text: 'PlayLists',
      ),
      backgroundColor: Colors.transparent,
      body: PlayLists(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          return ShowDialog(context, textEditingController, playerController);
        },
      ),
    );
  }
}
