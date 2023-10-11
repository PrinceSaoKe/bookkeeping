import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/bean/expect_expend_bean.dart';
import 'package:bookkeeping/bean/total_mon_data_bean.dart';
import 'package:bookkeeping/customed_widgets/customed_app_bar.dart';
import 'package:bookkeeping/customed_widgets/customed_cards.dart';
import 'package:flutter/material.dart';

class PlanDetailPage extends StatefulWidget {
  const PlanDetailPage({super.key});

  @override
  State<PlanDetailPage> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
  bool isLoading = true;
  List<ExpectExpendBean> expectList = [];
  List<TotalMonDataBean> totalMonList = [];

  double currIncome = 0.00;
  double currBalance = 0.00;
  double exceptExpend = 0.00;
  double currExpend = 0.00;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    DateTime dateTime = DateTime.now();
    ExpectExpendBean expectBean = await AppNet.expectExpend(date: dateTime);
    exceptExpend = expectBean.expectExpend ?? 0.00;
    TotalMonDataBean totalBean = await AppNet.totalMonData(dateTime: dateTime);
    currBalance = totalBean.currMonBalance ?? 0.00;
    currExpend = totalBean.currTotalMoney ?? 0.00;
    currIncome =
        (await AppNet.totalMonData(dateTime: dateTime, type: 'earning'))
                .currTotalMoney ??
            0.00;
    expectList.add(
      await AppNet.expectExpend(date: dateTime, subType: '餐饮'),
    );
    totalMonList
        .add(await AppNet.totalMonData(dateTime: dateTime, subType: '餐饮'));
    expectList.add(
      await AppNet.expectExpend(date: dateTime, subType: '娱乐'),
    );
    totalMonList
        .add(await AppNet.totalMonData(dateTime: dateTime, subType: '娱乐'));
    // expectList.add(
    //   await AppNet.expectExpend(date: dateTime, subType: '居家'),
    // );
    // totalMonList
    //     .add(await AppNet.totalMonData(dateTime: dateTime, subType: '居家'));
    // expectList.add(
    //   await AppNet.expectExpend(date: dateTime, subType: '文化'),
    // );
    // totalMonList
    //     .add(await AppNet.totalMonData(dateTime: dateTime, subType: '文化'));
    expectList.add(
      await AppNet.expectExpend(date: dateTime, subType: '交通'),
    );
    totalMonList
        .add(await AppNet.totalMonData(dateTime: dateTime, subType: '交通'));
    // expectList.add(
    //   await AppNet.expectExpend(date: dateTime, subType: '办公'),
    // );
    // totalMonList
    //     .add(await AppNet.totalMonData(dateTime: dateTime, subType: '办公'));
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomedAppBar('计划', centerTitle: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(overscroll: false),
              child: ListView(
                children: [
                  // Row(
                  //   children: const [
                  //     PlanSimpleCard(label: '计划（元）：        ', money: 20000.00),
                  //     PlanSimpleCard(label: '已省（元）：        ', money: 1278.00),
                  //   ],
                  // ),
                  PlanOrangeCard(
                    income: currIncome,
                    balance: currBalance,
                    save: exceptExpend,
                    expend: currExpend,
                  ),
                  PlanSubTypeCard(
                    imagePath: AppAssets.canying,
                    subType: '餐饮',
                    currExpend: totalMonList[0].currTotalMoney ?? 0,
                    lastExpend: totalMonList[0].lastMonMoney ?? 0,
                    dayAverage: totalMonList[0].dayAverage ?? 0,
                    expectExpend: expectList[0].expectExpend?.abs() ?? -1,
                  ),
                  PlanSubTypeCard(
                    imagePath: AppAssets.yule,
                    subType: '娱乐',
                    currExpend: totalMonList[1].currTotalMoney ?? 0,
                    lastExpend: totalMonList[1].lastMonMoney ?? 0,
                    dayAverage: totalMonList[1].dayAverage ?? 0,
                    expectExpend: expectList[1].expectExpend?.abs() ?? -1,
                  ),
                  // PlanSubTypeCard(
                  //   imagePath: AppAssets.jujia,
                  //   subType: '居家',
                  //   currExpend: totalMonList[2].currTotalMoney ?? 0,
                  //   lastExpend: totalMonList[2].lastMonMoney ?? 0,
                  //   dayAverage: totalMonList[2].dayAverage ?? 0,
                  //   expectExpend: expectList[2].expectExpend?.abs() ?? -1,
                  // ),
                  // PlanSubTypeCard(
                  //   imagePath: AppAssets.wenhuajiaoyu,
                  //   subType: '文化',
                  //   currExpend: totalMonList[3].currTotalMoney ?? 0,
                  //   lastExpend: totalMonList[3].lastMonMoney ?? 0,
                  //   dayAverage: totalMonList[3].dayAverage ?? 0,
                  //   expectExpend: expectList[3].expectExpend?.abs() ?? -1,
                  // ),
                  PlanSubTypeCard(
                    imagePath: AppAssets.jiaotong,
                    subType: '交通',
                    currExpend: totalMonList[2].currTotalMoney ?? 0,
                    lastExpend: totalMonList[2].lastMonMoney ?? 0,
                    dayAverage: totalMonList[2].dayAverage ?? 0,
                    expectExpend: expectList[2].expectExpend?.abs() ?? -1,
                  ),
                  // PlanSubTypeCard(
                  //   imagePath: AppAssets.bangong,
                  //   subType: '办公',
                  //   currExpend: totalMonList[5].currTotalMoney ?? 0,
                  //   lastExpend: totalMonList[5].lastMonMoney ?? 0,
                  //   dayAverage: totalMonList[5].dayAverage ?? 0,
                  //   expectExpend: expectList[5].expectExpend?.abs() ?? -1,
                  // ),
                ],
              ),
            ),
    );
  }
}
