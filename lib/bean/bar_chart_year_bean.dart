class BarChartYearBean {
  int? status;
  String? message;
  List<String>? label;
  // List<double>? value;
  List<double> value = [];
  double maxValue = 0;

  BarChartYearBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == null) return;
    Map data = map['data'];
    List? list1 = data['month'];
    label = list1?.cast<String>();
    List? list2 = data['money'];
    // value = list2?.cast<double>();
    if (list2 == null) return;
    for (var i = 0; i < list2.length; i++) {
      double current = double.parse(list2[i].toString());
      value.add(current);
      if (current > maxValue) maxValue = current;
    }
  }
}
