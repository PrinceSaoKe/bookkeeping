class TextSortBean {
  int? status;
  String? message;
  String? subType;

  TextSortBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    subType = map['data'];
  }
}
