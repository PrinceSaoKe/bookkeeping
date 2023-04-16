class ReceiptClassifyBean {
  int? status;
  String? message;
  String? receiptType;

  ReceiptClassifyBean.fromMap(Map map) {
    status = map['code'];
    message = map['message'];
    Map? result = map['result'];
    if (result == null) return;
    receiptType = result['type'];
  }
}
