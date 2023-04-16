import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/bean/bar_chart_mon_bean.dart';
import 'package:bookkeeping/customed_widgets/customed_app_bar.dart';
import 'package:bookkeeping/customed_widgets/customed_cards.dart';
import 'package:bookkeeping/customed_widgets/line_chart.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanSubTypePage extends StatefulWidget {
  const PlanSubTypePage({super.key});

  @override
  State<PlanSubTypePage> createState() => _PlanSubTypePageState();
}

class _PlanSubTypePageState extends State<PlanSubTypePage> {
  String imagePath = Get.arguments['image_path'];
  String subType = Get.arguments['subtype'];
  double currExpend = Get.arguments['curr_expend'];
  double lastExpend = Get.arguments['last_expend'];
  double dayAverage = Get.arguments['day_average'];
  double expectExpend = Get.arguments['expect_expend'];
  late BarChartMonBean bean;
  bool isLoading = true;
  final TextStyle _textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
  final TextStyle _bubbleStyle = const TextStyle(
    color: AppTheme.darkGold,
    fontSize: 25,
  );

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    DateTime dateTime = DateTime.now();
    bean = await AppNet.getBarChartMonthData(
      year: dateTime.year,
      month: dateTime.month,
      subType: subType,
    );
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomedAppBar('计划'),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  PlanSubTypeCard(
                    imagePath: imagePath,
                    subType: subType,
                    currExpend: currExpend,
                    lastExpend: lastExpend,
                    dayAverage: dayAverage,
                    expectExpend: expectExpend,
                    isDetail: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 120,
                      child: CustomedLineChart(
                        label: bean.label,
                        value: bean.value,
                        maxY: bean.maxValue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '   意见：',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.themeColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(
                            color: AppTheme.lightGreen,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: ListView(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            shrinkWrap: true,
                            children: [
                              Text(
                                '根据过往的消费数据信息，布奇预测您：',
                                style: _textStyle,
                              ),
                              // if (expectExpend >= 0)
                              Row(
                                children: [
                                  Text('本月在', style: _textStyle),
                                  const SizedBox(width: 10, height: 60),
                                  Text(subType, style: _bubbleStyle),
                                  const SizedBox(width: 10, height: 60),
                                  Text('类别', style: _textStyle),
                                  // const SizedBox(width: 10, height: 60),
                                ],
                              ),
                              Row(
                                children: [
                                  const Expanded(child: SizedBox(height: 0)),
                                  Text('会消费  ', style: _textStyle),
                                  Text(
                                    expectExpend.abs().toStringAsFixed(2),
                                    style: _bubbleStyle,
                                  ),
                                  const SizedBox(width: 10, height: 0),
                                  Text('元', style: _textStyle),
                                ],
                              ),
                              // if (expectExpend < 0)
                              //   Column(
                              //     children: [
                              //       const SizedBox(height: 20),
                              //       Text('数据太少无法预测', style: _bubbleStyle),
                              //     ],
                              //   ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  _getBubble(double x, double y) {
    return Align(
      alignment: Alignment(x, y),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppTheme.themeColor,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
