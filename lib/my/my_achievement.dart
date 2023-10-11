import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/bean/achievement_bean.dart';
import 'package:bookkeeping/customed_widgets/achievement_badge.dart';
import 'package:bookkeeping/customed_widgets/customed_app_bar.dart';
import 'package:flutter/material.dart';

class MyAchievementPage extends StatefulWidget {
  const MyAchievementPage({super.key});

  @override
  State<MyAchievementPage> createState() => _MyAchievementPageState();
}

class _MyAchievementPageState extends State<MyAchievementPage> {
  List<bool> lightList = [];
  List<bool> greyList = [];
  late AchievementBean bean;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    bean = await AppNet.getAchievementData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomedAppBar('我的成就'),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(overscroll: false),
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  _getLabel('已点亮'),
                  GridView.extent(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    maxCrossAxisExtent: 120,
                    children: [
                      if (bean.list[3])
                        AchievementBadge(
                          imagePath: AppAssets.travellerLight,
                          describe: '单月交通占比达到30%',
                        ),
                      if (bean.list[6])
                        AchievementBadge(
                          imagePath: AppAssets.foodLight,
                          describe: '单月饮食占比50%',
                        ),
                      if (bean.list[4])
                        AchievementBadge(
                          imagePath: AppAssets.educationLight,
                          describe: '单月文化用品+办公用品达到40%',
                        ),
                      if (bean.list[2])
                        AchievementBadge(
                          imagePath: AppAssets.loginLight,
                          describe: '单月收支结余金额达到2000',
                        ),
                      if (bean.list[7])
                        AchievementBadge(
                          imagePath: AppAssets.keepingLight,
                          describe: '单月累计收入达到2000',
                        ),
                      if (bean.list[0])
                        AchievementBadge(
                          imagePath: AppAssets.saveMoneyLight,
                          describe: '累计存入10000',
                        ),
                      if (bean.list[5])
                        AchievementBadge(
                          imagePath: AppAssets.makeupLight,
                          describe: '单月购物占比达到30%',
                        ),
                      if (bean.list[8])
                        AchievementBadge(
                          imagePath: AppAssets.sportsmanLight,
                          describe: '单月运动类型占比达到30%',
                        ),
                      if (bean.list[1])
                        AchievementBadge(
                          imagePath: AppAssets.entertainmentLight,
                          describe: '单月娱乐占比达到30%',
                        ),
                    ],
                  ),
                  _getLabel('未点亮'),
                  GridView.extent(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    maxCrossAxisExtent: 120,
                    children: [
                      if (!bean.list[3])
                        AchievementBadge(
                          imagePath: AppAssets.travellerGrey,
                          describe: '单月交通占比达到30%',
                        ),
                      if (!bean.list[6])
                        AchievementBadge(
                          imagePath: AppAssets.foodGrey,
                          describe: '单月饮食占比50%',
                        ),
                      if (!bean.list[4])
                        AchievementBadge(
                          imagePath: AppAssets.educationGrey,
                          describe: '单月文化用品+办公用品达到40%',
                        ),
                      if (!bean.list[2])
                        AchievementBadge(
                          imagePath: AppAssets.loginGrey,
                          describe: '单月收支结余金额达到2000',
                        ),
                      if (!bean.list[7])
                        AchievementBadge(
                          imagePath: AppAssets.keepingGrey,
                          describe: '单月累计收入达到2000',
                        ),
                      if (!bean.list[0])
                        AchievementBadge(
                          imagePath: AppAssets.saveMoneyGrey,
                          describe: '累计存入10000',
                        ),
                      if (!bean.list[5])
                        AchievementBadge(
                          imagePath: AppAssets.makeupGrey,
                          describe: '单月购物占比达到30%',
                        ),
                      if (!bean.list[8])
                        AchievementBadge(
                          imagePath: AppAssets.sportsmanGrey,
                          describe: '单月运动类型占比达到30%',
                        ),
                      if (!bean.list[1])
                        AchievementBadge(
                          imagePath: AppAssets.entertainmentGrey,
                          describe: '单月娱乐占比达到30%',
                        ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _getLabel(String text) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: AppTheme.lightGrey),
      ),
    );
  }
}
