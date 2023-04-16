class TotalMonDataBean {
  int? status;
  String? message;
  double? dayAverage;
  double? currTotalMoney;
  double? lastMonMoney;
  double? currMonBalance;

  TotalMonDataBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == null) return;
    Map data = map['data'];
    dayAverage = data['ave_data'];
    currTotalMoney = double.parse(data['date'].toString());
    lastMonMoney = double.parse(data['pre_data'].toString());
    currMonBalance = double.parse(data['res_data'].toString());
  }
}
