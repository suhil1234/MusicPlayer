import 'dart:ffi';

import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class recentController extends GetxController {
  OnAudioRoom audioRoom = OnAudioRoom();
  RxList recent = [].obs;

  queryRecent() async {
    await audioRoom
        .queryLastPlayed(
          limit: 50,
          sortType: null,
        )
        .then((value) => recent.value = value);
    for (int i = 0; i < recent.length; i++) {
      print(recent[i].title);
    }
  }

  isRecent(SongModel song, int index) async {
    addtoRecent(song, index);
  }

  addtoRecent(SongModel song, int index) async {
    await audioRoom.addTo(
      RoomType.LAST_PLAYED,
      song.getMap.toLastPlayedEntity(0),
    );
    await queryRecent();
  }

  removefromRecent(dynamic song, int index) async {
    await audioRoom.deleteFrom(RoomType.LAST_PLAYED, recent[index].key);
  }

  clearRecent() async {
    await OnAudioRoom().clearRoom(
      RoomType.LAST_PLAYED,
    );
    queryRecent();
  }
}
