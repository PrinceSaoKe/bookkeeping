class ExpectExpendBean {
  int? status;
  String? message;
  double? expectExpend;

  ExpectExpendBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    expectExpend = map['data'];
  }
}
