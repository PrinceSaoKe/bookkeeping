class SpeechRecognitionBean {
  int? status;
  String? message;
  String result = '对不起，没有听到您在说什么';

  SpeechRecognitionBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == null) return;
    result = map['data'];
  }
}
