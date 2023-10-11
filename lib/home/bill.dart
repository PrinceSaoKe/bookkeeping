import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/app_tools.dart';
import 'package:bookkeeping/bean/bill_bean.dart';
import 'package:bookkeeping/bean/universal_bean.dart';
import 'package:bookkeeping/customed_widgets/alert_dialog.dart';
import 'package:bookkeeping/customed_widgets/customed_button.dart';
import 'package:bookkeeping/customed_widgets/dash_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  int billID = Get.arguments['bill_id'];
  late BillBean bean;
  bool isLoading = true;
  DateTime? time;
  String? from;
  Image? image;
  String? type;
  String? receiptType;
  String? subType;
  double? money;
  String? item;
  String? remark;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    bean = await AppNet.getBill(billID: billID);
    time = bean.time ?? DateTime.now();
    from = bean.shop;
    image = bean.image;
    type = bean.type;
    receiptType = bean.itemType;
    subType = bean.subType;
    money = bean.money;
    item = bean.item;
    remark = bean.remark;

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, foregroundColor: AppTheme.darkGold),
      backgroundColor: AppTheme.themeColor,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.darkGold),
            )
          : ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(overscroll: false),
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          // 时间头
                          getTimeTitle(),
                          // 记账卡片
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 账单图片
                                    getBillImage(),
                                    const SizedBox(height: 20),
                                    // 账单信息
                                    getInfo(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getInfoTitleText('消费内容'),
                                        const SizedBox(height: 6),
                                        SizedBox(
                                          height: 50,
                                          child: getInfoText(item ?? '无'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getInfoTitleText('备注'),
                                        const SizedBox(height: 6),
                                        getInfoText(remark ?? ''),
                                      ],
                                    ),
                                    const SizedBox(height: 50),
                                    // 按钮
                                    getButton(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(top: 600, child: getDashLine()),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  /// 时间头
  Widget getTimeTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTimeTitleText('${time!.month}月${time!.day}日'),
              const SizedBox(height: 8),
              getTimeTitleText(
                '星期${AppTools.toDayOfWeek(time!)}',
                fontSize: 20,
              ),
              const SizedBox(height: 8),
              getTimeTitleText(
                AppTools.to0Hour0Min(time!),
                fontSize: 20,
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 150,
                child: getTimeTitleText(
                  from ?? '无',
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }

  /// 时间头的文字
  Text getTimeTitleText(
    String text, {
    double fontSize = 25,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: AppTheme.darkGold, fontSize: fontSize),
    );
  }

  /// 账单图片
  Widget getBillImage() {
    return GestureDetector(
      onTap: () {
        if (image == null) return;
        AppTools.showPopup(context, widget: image!);
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF707070)),
        ),
        child: Center(
          child: image == null
              ? const Text(
                  '暂无\n图片',
                  style: TextStyle(
                    color: Color(0xFFA5A5A5),
                    fontSize: 17,
                  ),
                )
              : SizedBox(height: 150, width: 150, child: image),
        ),
      ),
    );
  }

  /// 账单信息
  Widget getInfo() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (AppTools.getDeviceSize(context).width - 120) / 130,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getInfoTitleText('收支类型'),
            const SizedBox(height: 6),
            getInfoText('支出'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            getInfoTitleText('票据类型'),
            const SizedBox(height: 6),
            getInfoText(receiptType ?? '无'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getInfoTitleText('消费类型'),
            const SizedBox(height: 6),
            getInfoText(subType ?? '无'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            getInfoTitleText('消费金额'),
            const SizedBox(height: 6),
            getInfoText(money == null ? '无' : money.toString()),
          ],
        ),
      ],
    );
  }

  /// 按钮
  Widget getButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          CustomedOutlinedButton(
            name: '修改',
            color: AppTheme.darkGold,
            onPress: () {
              Get.toNamed(AppRouter.addBill, arguments: {
                'money': bean.money,
                'item': bean.item,
                'time': bean.time,
                'from': bean.shop,
                'receipt_type': bean.itemType,
                'sub_type': bean.subType,
                'remark': bean.remark,
                'image': bean.image,
              });
            },
          ),
          const Expanded(child: SizedBox()),
          CustomedOutlinedButton(
            name: '删除',
            color: AppTheme.lightGrey,
            onPress: () async {
              String result =
                  await alertDialog(context, title: '删除', text: '确认要删除该账单吗');
              if (result == '确定') {
                UniversalBean uniBean = await AppNet.deleteBill(billID: billID);
                await alertDialog(context,
                    title: uniBean.message ?? '未知错误', text: '');
                Get.until((route) => route.settings.name == AppRouter.root);
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  /// 账单信息标题文字
  Text getInfoTitleText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Color(0xFFA1BEBC), fontSize: 16),
    );
  }

  /// 账单信息内容文字
  Text getInfoText(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Color(0xFF425D58),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 账单卡片上的虚线
  Widget getDashLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppTheme.themeColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width - 80,
            child: const DashLine(color: Color(0xFFA9A9A9), width: 5.0),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppTheme.themeColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    );
  }
}
