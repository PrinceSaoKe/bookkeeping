import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/app_tools.dart';
import 'package:bookkeeping/bean/home_data_bean.dart';
import 'package:bookkeeping/bean/search_bill_bean.dart';
import 'package:bookkeeping/customed_widgets/bookkeeping_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 首页的支出结余卡片
class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.currBalance,
    required this.currExpend,
    required this.currIncome,
  });

  final double currExpend;
  final double currIncome;
  final double currBalance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          showBookkeepingSuggest(context);
        },
        child: Card(
          color: AppTheme.themeColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 10,
                child: Image.asset(
                  AppAssets.logo2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                child: SizedBox(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '本月支出',
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Text(
                          currExpend.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 44,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  '本月收入',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Text(
                                currIncome.toStringAsFixed(2),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(width: 60),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  '本月结余',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Text(
                                currBalance.toStringAsFixed(2),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 首页的账单卡片
class HomeBill extends StatelessWidget {
  const HomeBill({
    super.key,
    required this.time,
    this.pay = 0,
    this.income = 0,
    required this.bean,
  });

  final DateTime time;
  final double pay;
  final double income;
  final HomeDataDayBean bean;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 账单头
          Row(
            children: [
              Text(
                '${AppTools.toY0M0D(time)}星期${AppTools.toDayOfWeek(time)}',
              ),
              const Expanded(child: SizedBox()),
              Text(
                '支出: ${pay.toStringAsFixed(2)}  收入: +${income.toStringAsFixed(2)}',
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 账单卡片
          Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: ListView.builder(
              itemCount: bean.billList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                RoundedRectangleBorder? shape;
                if (bean.billList.length == 1) {
                  shape = const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  );
                } else if (index == 0) {
                  shape = const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  );
                } else if (index == bean.billList.length - 1) {
                  shape = const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  );
                }
                String moneyString = '';
                if (bean.billList[index].money > 0) moneyString += '+';
                moneyString += bean.billList[index].money.toString();
                return ListTile(
                  title: Text(bean.billList[index].subType),
                  trailing: Text(moneyString),
                  shape: shape,
                  onTap: () {
                    Get.toNamed(
                      AppRouter.bill,
                      arguments: {
                        'bill_id': bean.billList[index].billID,
                        'add_bill': null,
                        'image': null,
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 搜索结果界面的账单卡片
class SearchBill extends StatelessWidget {
  const SearchBill({
    super.key,
    required this.time,
    this.pay = 0,
    this.income = 0,
    required this.bean,
  });

  final DateTime time;
  final double pay;
  final double income;
  final SearchDayBillBean bean;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 账单头
          Row(
            children: [
              Text(
                '${AppTools.toY0M0D(time)}星期${AppTools.toDayOfWeek(time)}',
              ),
              const Expanded(child: SizedBox()),
              Text(
                '支出: ${pay.toStringAsFixed(2)}  收入: +${income.toStringAsFixed(2)}',
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 账单卡片
          Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: ListView.builder(
              itemCount: bean.billList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                RoundedRectangleBorder? shape;
                if (bean.billList.length == 1) {
                  shape = const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  );
                } else if (index == 0) {
                  shape = const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  );
                } else if (index == bean.billList.length - 1) {
                  shape = const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  );
                }
                String moneyString = '';
                if (bean.billList[index].money > 0) moneyString += '+';
                moneyString += bean.billList[index].money.toString();
                return ListTile(
                  title: Text(bean.billList[index].subtype),
                  trailing: Text(moneyString),
                  shape: shape,
                  onTap: () {
                    Get.toNamed(
                      AppRouter.bill,
                      arguments: {
                        'bill_id': bean.billList[index].billID,
                        'add_bill': null,
                        'image': null,
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 我的页面中的数据管理卡片
class DataManageCard extends StatelessWidget {
  const DataManageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Ink(
        height: 115,
        decoration: const BoxDecoration(
          color: AppTheme.lightGreen,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: () {
            Get.toNamed(AppRouter.dataManage);
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                const Positioned(
                  left: 0,
                  bottom: 0,
                  child: Text(
                    '数据管理',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Positioned(
                  child:
                      Image.asset(AppAssets.dataManage, height: 70, width: 70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 我的页面中的关于我们卡片
class AboutUsCard extends StatelessWidget {
  const AboutUsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 115,
      decoration: const BoxDecoration(
        color: AppTheme.orangeTheme,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: () {
          Get.toNamed(AppRouter.aboutUs);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              const Positioned(
                left: 0,
                bottom: 0,
                child: Text(
                  '关于我们',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Positioned(
                child: Image.asset(
                  AppAssets.aboutUs,
                  width: 90,
                  height: 90,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 我的页面中的成就卡片
class MyAchievementCard extends StatelessWidget {
  const MyAchievementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 115,
      decoration: const BoxDecoration(
        color: AppTheme.themeColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: () {
          Get.toNamed(AppRouter.myAchievement);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              const Positioned(
                left: 0,
                bottom: 0,
                child: Text(
                  '我的成就',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Positioned(
                child: Image.asset(
                  AppAssets.myAchievement,
                  width: 70,
                  height: 70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 报表页面的总计卡片
class FormCard extends StatelessWidget {
  const FormCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 50,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getLabelText(text: '总存款（元）：'),
                _getNumberText(text: '24542.88'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getLabelText(text: '本周支出（元）：'),
                _getNumberText(text: '456.33'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getLabelText(text: '本月支出（元）：'),
                _getNumberText(text: '866.63'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getLabelText(text: '本年支出（元）：'),
                _getNumberText(text: '866.63'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text _getLabelText({required String text}) {
    return Text(text, style: const TextStyle(fontSize: 12));
  }

  Text _getNumberText({required String text}) {
    return Text(text, style: const TextStyle(fontSize: 16));
  }
}

/// 报表页面中滑动报表里的卡片
class SlideFormDetailCard extends StatelessWidget {
  const SlideFormDetailCard({
    super.key,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
      child: Card(
        // margin: const EdgeInsets.all(10),
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(13)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getText('本年支出 (元)'),
                  _getText('36658.00'),
                  _getText('比上年支出 (元)'),
                  _getText('-276.00'),
                ],
              ),
              const Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _getText('本年支出 (元)'),
                  _getText('36658.00'),
                  _getText('比上年支出 (元)'),
                  _getText('-276.00'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
    );
  }
}

/// 计划页面简陋的浅绿色卡片
class PlanSimpleCard extends StatelessWidget {
  const PlanSimpleCard({super.key, required this.label, required this.money});

  final String label;
  final double money;
  final TextStyle labelStyle = const TextStyle(color: Colors.white);
  final TextStyle moneyStyle =
      const TextStyle(color: Colors.white, fontSize: 25);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: AppTheme.lightGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: labelStyle),
              const SizedBox(height: 20),
              Text(money.toString(), style: moneyStyle),
            ],
          ),
        ),
      ),
    );
  }
}

/// 计划页面橙色卡片
class PlanOrangeCard extends StatelessWidget {
  const PlanOrangeCard({
    super.key,
    required this.income,
    required this.balance,
    required this.save,
    required this.expend,
  });

  final double income;
  final double balance;
  final double save;
  final double expend;
  final TextStyle labelStyle = const TextStyle(color: Colors.white);
  final TextStyle moneyStyle =
      const TextStyle(color: Colors.white, fontSize: 25);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: AppTheme.orangeTheme,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Text('本月收入（元）：', style: labelStyle),
                    const SizedBox(height: 10),
                    Text(income.toString(), style: moneyStyle),
                    const SizedBox(height: 10),
                    Text('预计下月消费（元）：', style: labelStyle),
                    const SizedBox(height: 10),
                    if (save >= 0)
                      Text(save.toString(), style: moneyStyle)
                    else
                      const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          '数据太少无法预测',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Text('本月结余（元）：', style: labelStyle),
                    const SizedBox(height: 10),
                    Text(balance.toString(), style: moneyStyle),
                    const SizedBox(height: 10),
                    Text('本月支出（元）：', style: labelStyle),
                    const SizedBox(height: 10),
                    Text(expend.toString(), style: moneyStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 计划页面消费种类卡片
class PlanSubTypeCard extends StatelessWidget {
  const PlanSubTypeCard({
    super.key,
    required this.imagePath,
    required this.subType,
    required this.currExpend,
    required this.lastExpend,
    required this.dayAverage,
    required this.expectExpend,
    this.isDetail = false,
  });

  final String imagePath;
  final String subType;
  final double currExpend;
  final double lastExpend;
  final double dayAverage;
  final double expectExpend;
  final TextStyle subTypeStyle =
      const TextStyle(color: AppTheme.themeColor, fontSize: 25);
  final TextStyle labelStyle = const TextStyle(color: AppTheme.themeColor);
  final TextStyle moneyStyle = const TextStyle(fontSize: 25);
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRouter.planSubType, arguments: {
            'image_path': imagePath,
            'subtype': subType,
            'curr_expend': currExpend,
            'last_expend': lastExpend,
            'day_average': dayAverage,
            'expect_expend': expectExpend,
          });
        },
        child: Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(imagePath, width: 45, height: 45),
                    const SizedBox(width: 10),
                    Text(subType, style: subTypeStyle),
                    const Expanded(child: SizedBox()),
                    if (!isDetail)
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppTheme.lightGreen,
                        ),
                        child: const Center(
                          child: Text(
                            '详细分析',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Text('本月已消费', style: labelStyle)),
                    Expanded(child: Text('上月总消费', style: labelStyle)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(currExpend.toString(), style: moneyStyle),
                    ),
                    Expanded(
                      child: Text(lastExpend.toString(), style: moneyStyle),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Text('平均每日消费', style: labelStyle)),
                    Expanded(child: Text('预计本月消费', style: labelStyle)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        dayAverage.toStringAsFixed(2),
                        style: moneyStyle,
                      ),
                    ),
                    Expanded(
                      child: expectExpend == -1
                          ? const Text(
                              '数据太少无法预测',
                              style: TextStyle(fontSize: 18),
                            )
                          : Text(expectExpend.toString(), style: moneyStyle),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
