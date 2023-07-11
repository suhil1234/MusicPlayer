import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:prototype/controller/playcontroller.dart';

class SearchController extends GetxController {
  RxList SearchList = [].obs;
  RxString SearchTerm = "".obs;
  playontroller controller = Get.put(playontroller());

  changeSearchList(String value) {
    SearchList.value = controller.Songs.where(
        (item) => item.title.toLowerCase().contains(value)).toList();
  }
}
