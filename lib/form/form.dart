import 'dart:math';

import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/app_tools.dart';
import 'package:bookkeeping/bean/bar_chart_mon_bean.dart';
import 'package:bookkeeping/bean/bar_chart_week_bean.dart';
import 'package:bookkeeping/bean/bar_chart_year_bean.dart';
import 'package:bookkeeping/customed_widgets/bar_chart.dart';
import 'package:bookkeeping/customed_widgets/customed_app_bar.dart';
import 'package:bookkeeping/customed_widgets/customed_cards.dart';
import 'package:bookkeeping/customed_widgets/line_chart.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:bookkeeping/customed_widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool flag = true;
  Color backgroundColor = const Color(0xFFF5F5F5);
  late BarChartYearBean expendYearBean;
  late BarChartMonBean expendMonBean;
  late BarChartWeekBean expendWeekBean;
  late BarChartYearBean earningYearBean;
  late BarChartMonBean earningMonBean;
  late BarChartWeekBean earningWeekBean;
  bool isLoading = true;

  getChartData() async {
    DateTime dateTime = DateTime.now();
    expendYearBean = await AppNet.getBarChartYearData(year: dateTime.year);
    expendMonBean = await AppNet.getBarChartMonthData(
      year: dateTime.year,
      month: dateTime.month,
    );
    expendWeekBean = await AppNet.getBarChartWeekData(dateTime: dateTime);
    earningYearBean =
        await AppNet.getBarChartYearData(year: dateTime.year, type: 'earning');
    earningMonBean = await AppNet.getBarChartMonthData(
        year: dateTime.year, month: dateTime.month, type: 'earning');
    earningWeekBean =
        await AppNet.getBarChartWeekData(dateTime: dateTime, type: 'earning');
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomedAppBar(
        '收支报表',
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRouter.calendar);
            },
            child: const Icon(Icons.edit_calendar_outlined),
          ),
          const SizedBox(width: 15)
        ],
      ),
      backgroundColor: backgroundColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Stack(
                children: [
                  const FormCard(),
                  // logo标志水印
                  Align(
                    alignment: const Alignment(1.7, -0.4),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(AppAssets.orangeLogo),
                    ),
                  ),
                  // 周报
                  SlideForm(
                    color: AppTheme.orangeTheme,
                    title: '周报',
                    unSelectedHeight: 260,
                    selectedHeight: 590,
                    backgroundColor: backgroundColor,
                    foregroundColor: AppTheme.themeColor,
                    cardTextColor: AppTheme.themeColor,
                    cardBorderColor: AppTheme.themeColor,
                    expendBarChartLabel: expendWeekBean.label,
                    expendBarChartMaxValue: expendWeekBean.maxValue,
                    expendBarChartValue: expendWeekBean.value,
                    earningBarChartLabel: earningWeekBean.label,
                    earningBarChartValue: earningWeekBean.value,
                    earningBarChartMaxValue: earningWeekBean.maxValue,
                    colors: [
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[800]!,
                      AppTheme.themeColor[800]!,
                      AppTheme.themeColor[700]!,
                    ],
                  ),
                  // 月报
                  SlideForm(
                    color: AppTheme.lightGreen,
                    title: '月报',
                    unSelectedHeight: 180,
                    selectedHeight: 540,
                    backgroundColor: backgroundColor,
                    foregroundColor: AppTheme.themeColor,
                    cardBorderColor: Colors.white,
                    cardTextColor: Colors.white,
                    // expendBarChartLabel: expendMonBean.label,
                    expendBarChartLabel: [
                      '1日',
                      '2日',
                      '3日',
                      '4日',
                      '5日',
                      '6日',
                      '7日',
                      // '8日',
                      // '9日'
                    ],
                    // expendBarChartMaxValue: expendMonBean.maxValue,
                    expendBarChartMaxValue: 100,
                    // expendBarChartValue: expendMonBean.value,
                    expendBarChartValue: [32, 14, 66, 56, 90, 6, 50],
                    earningBarChartLabel: earningMonBean.label,
                    earningBarChartValue: earningMonBean.value,
                    earningBarChartMaxValue: earningMonBean.maxValue,
                    colors: [
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[800]!,
                      AppTheme.themeColor[800]!,
                      AppTheme.themeColor[700]!,
                    ],
                  ),
                  // 年报
                  SlideForm(
                    color: AppTheme.themeColor,
                    title: '年报',
                    unSelectedHeight: 100,
                    selectedHeight: 490,
                    backgroundColor: backgroundColor,
                    foregroundColor: Colors.white,
                    cardBorderColor: AppTheme.orangeTheme,
                    cardTextColor: Colors.white,
                    expendBarChartLabel: expendYearBean.label ??
                        [
                          '一月',
                          '二月',
                          '三月',
                          '四月',
                          '五月',
                          '六月',
                          '七月',
                          '八月',
                          '九月',
                          '十月',
                          '十一月',
                          '十二月'
                        ],
                    expendBarChartValue: expendYearBean.value,
                    expendBarChartMaxValue: expendYearBean.maxValue,
                    earningBarChartValue: earningYearBean.value,
                    earningBarChartMaxValue: earningYearBean.maxValue,
                    earningBarChartLabel: earningYearBean.label ??
                        [
                          '一月',
                          '二月',
                          '三月',
                          '四月',
                          '五月',
                          '六月',
                          '七月',
                          '八月',
                          '九月',
                          '十月',
                          '十一月',
                          '十二月'
                        ],
                    colors: [
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[900]!,
                      AppTheme.themeColor[800]!,
                      AppTheme.themeColor[800]!,
                      AppTheme.themeColor[700]!,
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

/// 报表页面上滑报表StatefulWidget
class SlideForm extends StatefulWidget {
  const SlideForm({
    super.key,
    required this.color,
    this.selectedHeight = 590,
    this.unSelectedHeight = 80,
    this.title = '周报',
    required this.backgroundColor,
    required this.foregroundColor,
    this.cardTextColor = Colors.white,
    this.cardBorderColor = Colors.white,
    required this.expendBarChartLabel,
    required this.expendBarChartValue,
    required this.expendBarChartMaxValue,
    required this.earningBarChartLabel,
    required this.earningBarChartMaxValue,
    required this.earningBarChartValue,
    required this.colors,
  });

  /// 滑动报表的背景色
  final Color color;

  /// 柱状图的颜色
  final Color foregroundColor;

  /// 滑动报表顶部椭圆形的颜色
  final Color backgroundColor;
  final Color cardTextColor;
  final Color cardBorderColor;
  final List<Color> colors;
  final double selectedHeight;
  final double unSelectedHeight;
  final String title;
  final List<String> expendBarChartLabel;
  final List<double> expendBarChartValue;
  final double expendBarChartMaxValue;
  final List<String> earningBarChartLabel;
  final List<double> earningBarChartValue;
  final double earningBarChartMaxValue;

  @override
  State<SlideForm> createState() => _SlideFormState();
}

/// 报表页面上滑报表State
class _SlideFormState extends State<SlideForm> {
  bool isSelected = false;
  bool isPay = true;
  PageController controller = PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      isPay = controller.page! < 0.5 ? true : false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          isSelected = !isSelected;
          setState(() {});
        },
        child: AnimatedContainer(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
          height: isSelected ? widget.selectedHeight : widget.unSelectedHeight,
          width: AppTools.getDeviceSize(context).width - 40,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: CustomScrollView(
                slivers: [
                  _buildStickyBar(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                      (context, index) {
                        return SizedBox(
                          width: AppTools.getDeviceSize(context).width,
                          height: AppTools.getDeviceSize(context).height,
                          child: PageView(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            children: [_payBody(), _incomeBody()],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 报表头
  Widget _buildStickyBar() {
    double topBarHeight = 40;
    return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: _SliverAppBarDelegate(
        minHeight: topBarHeight, //收起的高度
        maxHeight: topBarHeight, //展开的最大高度
        child: Flex(
          direction: Axis.horizontal,
          children: [
            // 报表标题
            Expanded(
              flex: 2,
              child: Container(
                height: topBarHeight,
                width: double.infinity,
                color: widget.color,
                child: Center(
                  child: Text(
                    '${widget.title} ',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            // 白色椭圆
            Expanded(
              flex: 3,
              child: Container(
                height: topBarHeight,
                color: widget.color,
                child: Center(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            // 页面切换
            Expanded(
              flex: 2,
              child: Container(
                height: topBarHeight,
                color: widget.color,
                child: Center(
                  child: TextButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (!isSelected) {
                        isSelected = !isSelected;
                        setState(() {});
                        return;
                      }
                      controller.animateToPage(
                        isPay ? 1 : 0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                      setState(() {});
                    },
                    icon: const Icon(Icons.compare_arrows_rounded),
                    label: isPay ? const Text('支出') : const Text('收入'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 支出页面
  Widget _payBody() {
    return AnimatedOpacity(
      opacity: isSelected ? 1 : 0,
      duration: const Duration(milliseconds: 1000),
      child: ListView(
        children: [
          SizedBox(
            height: 150,
            child: isSelected
                ? CustomedBarChart(
                    label: widget.expendBarChartLabel,
                    value: widget.expendBarChartValue,
                    color: widget.foregroundColor,
                    // maxY: 120,
                    maxY: widget.expendBarChartMaxValue * 1.2,
                    barsSpacing: 25,
                    textOffset: -5,
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: 30),
          SlideFormDetailCard(
            textColor: widget.cardTextColor,
            backgroundColor: widget.color,
            borderColor: widget.cardBorderColor,
          ),
          const Text(
            '  支出分类构成',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          // const SizedBox(height: 30),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              SizedBox(
                height: 300,
                width: 200,
                // color: Colors.black,
                child: CustomedPieChart(
                  label: const ['一月', '二月', '三月', '四月', '五月', '六月', '七月'],
                  value: const [80, 70, 10, 35, 100, 90, 55],
                  colors: widget.colors,
                  outerBorderColor: Colors.white,
                  innerCircleColor: widget.color,
                  textColor: widget.cardTextColor,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 400),
        ],
      ),
    );
  }

  /// 收入页面
  _incomeBody() {
    return AnimatedOpacity(
      opacity: isSelected ? 1 : 0,
      duration: const Duration(milliseconds: 1000),
      child: ListView(
        children: [
          SizedBox(
            height: 150,
            child: isSelected
                ? CustomedBarChart(
                    // label: widget.earningBarChartLabel,
                    label: const ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                    // value: widget.earningBarChartValue,
                    value: const [34, 56, 12, 43, 89, 79, 23],
                    color: widget.foregroundColor,
                    // maxY: widget.earningBarChartMaxValue * 1.2,
                    maxY: 100,
                    barsSpacing: 25,
                    textOffset: -5,
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: 30),
          SlideFormDetailCard(
            textColor: widget.cardTextColor,
            backgroundColor: widget.color,
            borderColor: widget.cardBorderColor,
          ),
          SizedBox(
            height: 200,
            child: CustomedLineChart(
                label: const ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                value: const [34, 56, 12, 43, 89, 79, 23],
                maxY: 100),
          )
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
