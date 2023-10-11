import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/customed_widgets/customed_app_bar.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomedAppBar('关于我们'),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            // APP图标
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      color: AppTheme.themeColor,
                      image: DecorationImage(
                        image: AssetImage(AppAssets.logo),
                        scale: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  getTitleText(
                    '布奇\n(Bookkeeping)',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            getTitleText('介绍'),
            const SizedBox(height: 10),
            getInfoText(
              '        本产品是一款基于智能文字场景个人财务管理应用，可通过图片识别，拍照等快捷的方式进行账单记录，通过数据分析提供有效省钱规划。让记账更便捷，更随心。',
            ),
            const SizedBox(height: 20),
            getTitleText('联系方式'),
            const SizedBox(height: 10),
            getInfoText(
              '        邮箱：bookkeeping@fzu.com',
            ),
            const SizedBox(height: 30),
            getTitleText('使用条款', textDecoration: TextDecoration.underline),
            const SizedBox(height: 20),
            getTitleText('隐私政策', textDecoration: TextDecoration.underline),
          ],
        ),
      ),
    );
  }

  /// 标题文字
  Text getTitleText(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: AppTheme.themeColor,
        fontSize: 22,
        decoration: textDecoration,
      ),
    );
  }

  /// 内容文字
  Text getInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Color(0xFF707070), fontSize: 18),
    );
  }
}
