import 'package:flutter/material.dart';

class HomeDataBean {
  int? status;
  String? message;
  double? totalExpend;
  double? totalEarning;
  List<HomeDataDayBean> dayList = [];

  HomeDataBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == null) return;
    Map data = map['data'];
    totalExpend = double.parse(data['expend'].toString());
    totalEarning = double.parse(data['earning'].toString());
    List list = data['data_day'];
    for (var i = 0; i < list.length; i++) {
      dayList.add(HomeDataDayBean.fromMap(list[i]));
    }
  }
}

class HomeDataDayBean {
  late DateTime date;
  late double expend;
  late double earning;
  List<HomeDataBillBean> billList = [];

  HomeDataDayBean.fromMap(Map map) {
    date = DateTime.parse(map['date']);
    expend = double.parse(map['expend'].toString());
    earning = double.parse(map['earning'].toString());
    List list = map['day_list'];
    for (var i = 0; i < list.length; i++) {
      billList.add(HomeDataBillBean.fromMap(list[i]));
    }
  }
}

class HomeDataBillBean {
  late int billID;
  late String subType;
  late double money;
  late TimeOfDay time;

  HomeDataBillBean.fromMap(Map map) {
    billID = map['id'];
    subType = map['subtype'];
    money = map['subtype_money'];
    time = TimeOfDay.fromDateTime(DateTime.parse('2023-04-13 ${map['time']}'));
  }
}
