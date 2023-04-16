class UniversalBean {
  int? status;
  String? message;

  UniversalBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
  }
}
