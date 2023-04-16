class ShopTicketBean {
  int? status;
  String? message;
  int? costTime;
  int? imageAngle;
  int? rotatedImageWidth;
  int? rotatedImageHeight;
  double? money;
  String itemType = '小票';
  String? subType = '餐饮';
  DateTime? time;
  List<dynamic>? itemList;

  /// 单号
  String? no;

  /// 商户
  String? shop;

  /// 商户编号
  String? shopNo;

  /// 商品
  String? item;

  ShopTicketBean.fromMap(Map map) {
    List<dynamic>? infoList;
    List<dynamic>? objectList = [];
    Map<String, dynamic>? result;

    status = map['code'];
    message = map['message'];
    costTime = map['cost_time'];
    result = map['result'];
    objectList = result?['object_list'];
    imageAngle = result?['image_angle'];
    rotatedImageWidth = result?['rotated_image_width'];
    rotatedImageHeight = result?['rotated_image_height'];
    infoList = result?['item_list'];
    if (objectList?.isNotEmpty ?? false) {
      // itemType = objectList![0]['type'];
      itemList = objectList![0]['item_list'];
    }

    infoList?.forEach((element) {
      switch (element['key']) {
        case 'money':
          if (element['value'] == '') break;
          money = double.parse(element['value']);
          break;
        case 'date':
          if (element['value'] == '') break;
          time = DateTime.tryParse(element['value']);
          break;
        case 'no':
          no = element['value'];
          break;
        case 'shop':
          shop = element['value'];
          break;
        case 'shop_no':
          shopNo = element['value'];
          break;
        case 'sku':
          item = element['value'];
          break;
        default:
          break;
      }
    });
  }

  @override
  String toString() =>
      '$message！金额：$money，时间：$time，单号：$no，商户：$shop，商户编号：$shopNo，商品：$item';
}

// class Goods {
//   int? amount;
//   String? name;
//   double? price;

//   Goods(this.amount, this.name, this.price);
// }
