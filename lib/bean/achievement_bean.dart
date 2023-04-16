class AchievementBean {
  int? status;
  String? message;
  List<bool> list = [];

  AchievementBean.fromMap(Map map) {
    status = map['status'];
    message = map['message'];
    if (map['data'] == null) return;
    Map data = map['data'];
    list.add(data['大富翁']);
    list.add(data['大玩家']);
    list.add(data['小达人']);
    list.add(data['旅行家']);
    list.add(data['求知者']);
    list.add(data['美妆家']);
    list.add(data['美食家']);
    list.add(data['记账家']);
    list.add(data['运动者']);
  }
}
