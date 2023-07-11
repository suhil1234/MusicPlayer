import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prototype/view/widgets/FavoriteList.dart';

import 'widgets/CustomAppBar.dart';

class favoriteScreen extends StatefulWidget {
  const favoriteScreen({super.key});

  @override
  State<favoriteScreen> createState() => _favoriteScreenState();
}

class _favoriteScreenState extends State<favoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const customAppBar(
        text: 'Favorites',
      ),
      backgroundColor: Colors.transparent,
      body: FavoriteList(),
    );
  }
}
