class BarChartMonBean {
  int? status;
  String? message;
  List<String> label = [];
  List<double> value = [];
  double maxValue = 0;

  BarChartMonBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == null) return;
    Map data = map['data'];
    List list1 = data['day'];
    for (var i = 0; i < list1.length; i++) {
      label.add('${list1[i]}日');
    }
    List list2 = data['money'];
    for (var i = 0; i < list2.length; i++) {
      double current = double.parse(list2[i].toString());
      value.add(current);
      if (current > maxValue && i < 7) maxValue = current;
    }
  }
}
