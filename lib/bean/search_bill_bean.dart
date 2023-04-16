class SearchBillBean {
  int? status;
  String? message;
  int? billCount;
  String? type;
  List<SearchDayBillBean> dayList = [];

  SearchBillBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == null) return;
    Map data = map['data'];
    billCount = data['len'];
    type = data['type'];
    List list = data['data_day'];
    for (var i = 0; i < list.length; i++) {
      dayList.add(SearchDayBillBean.fromMap(list[i]));
    }
  }
}

class SearchDayBillBean {
  late String date;
  List<SearchDetailBillBean> billList = [];
  late double income;
  late double expend;

  SearchDayBillBean.fromMap(Map map) {
    date = map['date'];
    income = double.parse(map['earning'].toString());
    expend = double.parse(map['expend'].toString());
    List list = map['day_list'];
    for (var i = 0; i < list.length; i++) {
      billList.add(SearchDetailBillBean.fromMap(list[i]));
    }
  }
}

class SearchDetailBillBean {
  late int billID;
  late String subtype;
  late double money;
  late String time;

  SearchDetailBillBean.fromMap(Map map) {
    billID = map['id'];
    subtype = map['subtype'];
    money = map['subtype_money'];
    time = map['time'];
  }
}
