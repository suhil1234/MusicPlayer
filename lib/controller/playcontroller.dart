import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prototype/controller/favoriteController.dart';
import 'package:prototype/view/addToPlaylistPage.dart';
import 'RecentController.dart';

class playontroller extends GetxController {
  recentController recentcontroller = Get.put(recentController());
  var audio = OnAudioQuery();
  var player = AudioPlayer();

  Rx<Duration> duration = Duration(seconds: 0).obs;
  Rx<Duration> position = Duration(seconds: 0).obs;

  final Rx<int> currentStreamIndex = 1000000000.obs;
  final Rx<int> currentmode = 0.obs;

  RxBool isblaying = false.obs;
  RxBool smallPlayerVisibilty = false.obs;

  List<AudioSource> SongsData = [];
  RxList recent = [].obs;
  late List<SongModel> Songs;
  late List<SongModel> currentList;
  late List temp;

  var hive = Hive.box('myBox');

  @override
  void onInit() {
    super.onInit();
    requestPermmision();
    PlayerChange();
  }

  initilalize() {
    Songs.removeWhere((element) => !(element.fileExtension.contains("mp3")));
    int i = 0;
    Songs.forEach((element) {
      print(element.title);
      SongsData.add(AudioSource.uri(
        Uri.parse(element.uri!),
      ));
    });

    player.setAudioSource(ConcatenatingAudioSource(children: SongsData));
  }

  requestPermmision() async {
    var per = await Permission.storage.status;
    if (per.isDenied) {
      Permission.storage.request();
    }
  }

  PlayerChange() {
    player.durationStream.listen((d) => duration.value = d!);
    player.positionStream.listen((p) => position.value = p);
    player.currentIndexStream.listen((event) {
      currentStreamIndex.value = event!;
    });
  }

  void play() async {
    if (isblaying == true) {
      pause();
    } else {
      resume();
    }
  }

  void playNew() async {
    smallPlayerVisibilty.value = true;
    player.stop();
    isblaying.value = true;
    await player.seek(const Duration(seconds: 0),
        index: currentStreamIndex.value);
    player.play();
    await recentcontroller.isRecent(
        Songs[currentStreamIndex.value], currentStreamIndex.value);
  }

  void resume() async {
    isblaying.value = true;
    player.seek(position.value);
    player.play();
  }

  void pause() async {
    isblaying.value = false;
    player.pause();
  }

  void changemood() async {
    switch (currentmode.value) {
      case 1:
        player.setLoopMode(LoopMode.one);
        break;
      case 2:
        player.setLoopMode(LoopMode.all);
        break;
      case 3:
        player.setShuffleModeEnabled(true);
        break;
      default:
    }
  }

  void next() async {
    if (player.hasNext) {
      player.seekToNext();
      player.play();
      isblaying.value = true;
      await recentcontroller.isRecent(
          Songs[currentStreamIndex.value], currentStreamIndex.value);
    }
  }

  void back() async {
    if (player.hasPrevious) {
      player.seekToPrevious();
      player.play();
      isblaying.value = true;
      await recentcontroller.isRecent(
          Songs[currentStreamIndex.value], currentStreamIndex.value);
    }
  }

  void stop() {
    isblaying.value = false;
    player.stop();
  }

  set setPositionValue(double value) =>
      player.seek(Duration(seconds: value.toInt()));
}
