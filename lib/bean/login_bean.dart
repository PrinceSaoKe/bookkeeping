import 'package:bookkeeping/app_data.dart';

class LoginBean {
  int? status;
  String? message;
  int? id;
  String? telephone;
  String? userName;
  String? password;

  LoginBean.formMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == '') return;
    Map? data = map['data'];
    if (data == null) return;
    id = data['id'];
    if (id != null) {
      AppData appData = AppData();
      appData.box.write('currUserID', id);
    }
    telephone = data['telephone'];
    userName = data['username'];
    if (userName != null) {
      AppData appData = AppData();
      appData.box.write('currUserName', userName);
    }
    password = data['password'];
  }
}
