class TrainTicketBean {
  int? status;
  String? message;
  double? money;
  String itemType = '火车票';
  String subType = '交通';
  DateTime? time;
  String? item;
  String departureStation = '';
  String arrivalStation = '';
  String shop = '中国中铁';

  /// 车次号
  String? trainID;

  TrainTicketBean.fromMap(Map map) {
    status = map['code'];
    message = map['message'];
    Map? result = map['result'];
    if (result == null) return;
    List itemList = result['item_list'];
    departureStation = itemList[2]['value'];
    trainID = itemList[3]['value'];
    arrivalStation = itemList[4]['value'];
    time = DateTime.parse(itemList[5]['value']);
    money = double.tryParse(itemList[7]['value']);

    item = '$trainID$departureStation-$arrivalStation';
  }
}
