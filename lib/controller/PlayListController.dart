import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:prototype/controller/playcontroller.dart';
import '../view/widgets/showToast.dart';

class PlayListController extends GetxController {
  playontroller controller = Get.put(playontroller());
  var audio = OnAudioQuery();
  RxList playlists = [].obs;
  RxList Playlist = [].obs;
  RxBool DialogSubmited = false.obs;
  showtoast toast = showtoast();
  var hive = Hive.box('myBox');

  createplayList(String name) async {
    await audio.createPlaylist(name);
    await queryplaylists();
  }

  removeeplayList(int id) async {
    await audio.removePlaylist(id);
    await queryplaylists();
  }

  Future<List<PlaylistModel>> queryplaylists() async {
    await audio
        .queryPlaylists(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL)
        .then((value) => playlists.value = value);
    throw {errorTextConfiguration};
  }

  fetch(int index) {
    List<SongModel> songs;
    songs = controller.Songs.where(
        (element) => element.title == Playlist[index].title).toList();
    return songs[0];
  }

  addToPlaylist(int playlistId, int audioId) async {
    await audio.addToPlaylist(playlistId, audioId);
    toast.showToast('added to playList');
    savetoPlayList(playlistId, audioId, true);
    querPlayListSongs(playlistId);
  }

  removeFromPlaylist(int playlistId, int audioId) async {
    await audio.removeFromPlaylist(playlistId, audioId);
    toast.showToast('removed from playList');
    savetoPlayList(playlistId, audioId, false);
    querPlayListSongs(playlistId);
  }

  querPlayListSongs(int id) async {
    await audio
        .queryAudiosFrom(AudiosFromType.PLAYLIST, id)
        .then((value) => Playlist.value = value);
  }

  savetoPlayList(int id, int songid, bool value) {
    String key = id.toString() + songid.toString();
    hive.put(key, value);
  }

  loadfromPlayList(int id, int songid) {
    String key = id.toString() + songid.toString();
    return hive.get(key);
  }
}
