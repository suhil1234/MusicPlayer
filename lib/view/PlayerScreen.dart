import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/controller/favoriteController.dart';
import '../controller/RecentController.dart';
import '../controller/playcontroller.dart';
import '../view/constants/Duration_ext.dart';
import 'constants/constants.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  playontroller controller = Get.put(playontroller());
  favoriteController favcontroller = Get.put(favoriteController());

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    var data = controller.Songs;
    ThemeData theme = Theme.of(context);
    Color secondary = Theme.of(context).colorScheme.secondary;
    int index = controller.currentStreamIndex.value;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // ignore: prefer_const_constructors
          title: Center(
            child: const Text(
              'My Player',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.keyboard_option_key_outlined))
          ],
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
        ),
        extendBodyBehindAppBar: true,
        body: Obx(() {
          return Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.expand,
            children: [
              QueryArtworkWidget(
                id: data[controller.currentStreamIndex.value].id,
                type: ArtworkType.AUDIO,
              ),
              ShaderMask(
                blendMode: BlendMode.dstOut,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.0)
                      ],
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      stops: const [0.0, 0.4, 0.6]).createShader(bounds);
                },
                child: Container(
                  decoration: shaderDecoration(context, null, null),
                ),
              ),
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(data[controller.currentStreamIndex.value].title,
                        style: TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        data[controller.currentStreamIndex.value].artist ??
                            'UnKnown',
                        style: TextStyle(fontSize: 15)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(() {
                        return Row(
                          children: [
                            Text(
                              controller.position.value.timeFormat,
                              style: TextStyle(fontSize: 15),
                            ),
                            Expanded(
                                child: Slider.adaptive(
                              activeColor: secondary,
                              inactiveColor: Theme.of(context).primaryColor,
                              value: controller.position.value.inSeconds
                                  .toDouble(),
                              min: 0.0,
                              max: controller.duration.value.inSeconds
                                      .toDouble() +
                                  1.0,
                              onChanged: (v) {
                                controller.setPositionValue = v;
                              },
                            )),
                            Text(
                              controller.duration.value.timeFormat,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        );
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.shuffle, size: 30, color: secondary),
                          onPressed: () {
                            if (controller.currentmode.value == 4) {
                              controller.currentmode.value = 0;
                            } else {
                              controller.currentmode.value++;
                            }
                            controller.changemood();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_previous,
                              size: 30, color: secondary),
                          onPressed: () {
                            controller.back();
                          },
                        ),
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: IconButton(
                              onPressed: () {
                                controller.play();
                              },
                              iconSize: 40,
                              icon: Icon(
                                (controller.isblaying.value == true)
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
                        IconButton(
                          icon:
                              Icon(Icons.skip_next, size: 30, color: secondary),
                          onPressed: () {
                            controller.next();
                          },
                        ),
                        Obx(() {
                          print(controller.currentStreamIndex.value);
                          return FavoriteButton(
                            iconSize: 40,
                            isFavorite: favcontroller.loadfav(
                                data[controller.currentStreamIndex.value]
                                    .title),
                            valueChanged: (v) async {
                              v == false
                                  ? await favcontroller.removefromFav(
                                      data[controller.currentStreamIndex.value],
                                      controller.currentStreamIndex.value)
                                  : await favcontroller.addtoFav(
                                      data[controller.currentStreamIndex.value],
                                      index);
                              favcontroller.savefav(
                                  data[controller.currentStreamIndex.value]
                                      .title,
                                  v);
                            },
                          );
                        })
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
