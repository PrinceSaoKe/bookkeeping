import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/customed_widgets/customed_cards.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.themeColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
            child: GestureDetector(
              child: const Text(
                '切换账号',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Get.toNamed(AppRouter.login);
              },
            ),
          ),
        ],
      ),
      body: ScrollConfiguration(
        // 取消过度滚动水波纹效果
        behavior: OverScrollBehavior(),
        child: ListView(
          children: [
            // Logo背景
            Container(
              height: 150,
              color: AppTheme.themeColor,
              child: Center(
                child: Image.asset(AppAssets.logo2, scale: 0.85),
              ),
            ),
            // 头像与用户名
            Container(
              padding: const EdgeInsets.fromLTRB(25, 13, 25, 13),
              height: 150,
              color: AppTheme.themeColor,
              child: Row(
                children: [
                  Column(
                    children: [
                      // 头像
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouter.pieChart);
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: AppTheme.orangeTheme,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(AppAssets.darkGreenAvatar),
                          ),
                        ),
                      ),
                      // 用户名
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '用户名',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  // 记账天数
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          '已坚持记账:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          '52天',
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const DataManageCard(),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: const [
                  Expanded(child: AboutUsCard()),
                  SizedBox(width: 10),
                  Expanded(child: MyAchievementCard()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
