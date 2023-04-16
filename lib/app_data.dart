import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppData extends GetxController {
  final box = GetStorage();
  // int get currUserID => int.parse(box.read('currUserID'));
  int? get currUserID => box.read('currUserID');
  String get currUserName => box.read('currUserName');

  initData() {
    if (box.read('currUserID') == null) {
      box.write('currUserID', 1);
    }
    if (box.read('currUserName') == null) {
      box.write('currUserName', '游客登录');
    }
    if (box.read('currLanguage') == null) {
      box.write('currLanguage', '中文');
    }
  }
}
