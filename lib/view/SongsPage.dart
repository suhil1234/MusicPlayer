import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/widgets/SongsList.dart';
import '../controller/playcontroller.dart';
import '../view/widgets/CustomAppBar.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  playontroller controller = Get.put(playontroller());

  @override
  Widget build(BuildContext context) {
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    // ignore: prefer_const_constructors
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const customAppBar(
          text: 'My Songs',
        ),
        body: SongsList());
  }
}
