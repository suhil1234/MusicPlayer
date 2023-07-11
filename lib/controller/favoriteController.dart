import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import '../view/widgets/showToast.dart';

class favoriteController extends GetxController {
  OnAudioRoom audioRoom = OnAudioRoom();
  showtoast toast = showtoast();
  RxList favorite = [].obs;
  late RxBool isfav;
  var hive = Hive.box('myBox');

  queryFavorite() async {
    await audioRoom
        .queryFavorites(
          limit: 50,
          reverse: false,
          sortType: null,
        )
        .then((value) => favorite.value = value);
    print(favorite.value);
  }

  removefromFav(dynamic song, int index) async {
    dynamic fav = favorite
        .where((item) => item.title.toLowerCase() == song.title.toLowerCase())
        .toList();
    await audioRoom.deleteFrom(RoomType.FAVORITES, fav[0].key);
    await queryFavorite();
    await toast.showToast('removed from favorite');
  }

  addtoFav(SongModel song, int index) async {
    toast.showToast('added to favorite');
    await audioRoom.addTo(
      RoomType.FAVORITES,
      song.getMap.toFavoritesEntity(),
    );
    await queryFavorite();
  }

  savefav(dynamic index, bool value) {
    hive.put(index, value);
  }

  loadfav(dynamic index) {
    return hive.get(index) ?? false;
  }
}
