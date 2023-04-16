import 'package:bookkeeping/app_net.dart';
import 'package:flutter/cupertino.dart';

class BillBean {
  int? status;
  String? message;
  int? billID;
  String? type;
  String? subType;
  String? itemType;
  DateTime? time;
  double? money;
  String? shop;
  String? item;
  String? remark;
  Image? image;

  BillBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == null) return;
    Map data = map['data'];
    billID = data['id'];
    type = data['type'];
    subType = data['subtype'];
    itemType = data['bill'];
    time = DateTime.parse(data['date'] + ' ' + data['time']);
    money = double.tryParse(data['money'].toString());
    shop = data['froms'];
    item = data['value'];
    remark = data['remarks'];
    if (data['image'] == null) return;
    image = Image.network(AppNet.baseURL + data['image']);
  }
}
