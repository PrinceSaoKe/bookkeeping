class ExchangeRateBean {
  int? status;
  String? message;
  String? currType;
  double? currMoney;
  String? currTypeEnglish;
  List<ExchangeRateCountryBean> list = [];

  ExchangeRateBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == null) return;
    Map data = map['data'];
    currType = data['type1'];
    currMoney = data['money1'];
    currTypeEnglish = data['abbr1'];
    List tempList = data['list'];
    list.add(ExchangeRateCountryBean.fromMap(
      {'type2': currType, 'money2': currMoney, 'abbr2': currTypeEnglish},
    ));
    for (var i = 0; i < 8; i++) {
      list.add(ExchangeRateCountryBean.fromMap(tempList[i]));
    }
  }
}

class ExchangeRateCountryBean {
  late String moneyType;
  late double money;
  late String moneyTypeEnglish;

  ExchangeRateCountryBean.fromMap(Map map) {
    moneyType = map['type2'];
    money = map['money2'];
    moneyTypeEnglish = map['abbr2'];
  }
}
