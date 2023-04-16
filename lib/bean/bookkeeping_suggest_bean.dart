class BookkeepingSuggestBean {
  int? status;
  String? message;
  String? suggestion;

  BookkeepingSuggestBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    suggestion = map['data'];
  }
}
