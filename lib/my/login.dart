import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/bean/login_bean.dart';
import 'package:bookkeeping/customed_widgets/alert_dialog.dart';
import 'package:bookkeeping/customed_widgets/customed_button.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController teleCtrller = TextEditingController();
  TextEditingController passwordCtrller = TextEditingController();
  bool isFirstInstall = true;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      if (Get.arguments['is_first_install'] != null) {
        isFirstInstall = Get.arguments['is_first_install'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.themeColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
            child: GestureDetector(
              child: const Text(
                '注册',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Get.toNamed(AppRouter.register);
              },
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.themeColor,
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView(
          padding: const EdgeInsets.only(left: 50, right: 50),
          children: [
            Image.asset(AppAssets.logo, width: 200, height: 200),
            const SizedBox(height: 20),
            LoginTextField(
              controller: teleCtrller,
              hintText: '请输入手机号',
              icon: const Icon(Icons.smartphone, color: Colors.white),
            ),
            const SizedBox(height: 30),
            LoginTextField(
              controller: passwordCtrller,
              hintText: '请输入密码',
              hideText: true,
              icon: const Icon(Icons.lock_outline, color: Colors.white),
            ),
            const SizedBox(height: 50),
            LoginButton(
              onTap: () async {
                LoginBean bean = await AppNet.login(
                  tele: teleCtrller.text,
                  password: passwordCtrller.text,
                );
                await alertDialog(
                  context,
                  title: bean.status == 200 ? '成功！' : '失败！',
                  text: bean.message ?? '未知错误',
                );
                if (!isFirstInstall && bean.status == 200) {
                  Get.until((route) => route.settings.name == AppRouter.root);
                } else if (isFirstInstall && bean.status == 200) {
                  Get.offAllNamed(AppRouter.root);
                }
              },
            ),
            const SizedBox(height: 50),
            const OtherLogin(),
          ],
        ),
      ),
    );
  }
}

// 登录输入框
class LoginTextField extends StatelessWidget {
  // 在输入框尾部的组件
  Widget? suffix;
  TextEditingController controller;
  String? hintText;
  bool hideText;
  TextInputType? inputType;
  Icon? icon;
  LoginTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.suffix,
    this.hideText = false,
    this.inputType,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 270,
      child: TextField(
        controller: controller,
        // 输入密码模式
        obscureText: hideText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: icon ??
              const Icon(
                Icons.circle,
                color: Colors.white,
                size: 20,
              ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintStyle: const TextStyle(color: Colors.white),
          suffix: suffix,
          hintText: hintText,
        ),
        cursorColor: Colors.white,
        // 输入类型
        keyboardType: inputType,
      ),
    );
  }
}

// 第三方登录
class OtherLogin extends StatelessWidget {
  const OtherLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 70, height: 1, color: Colors.black),
            const SizedBox(width: 20),
            const Text(
              '第三方登录',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(width: 20),
            Container(width: 70, height: 1, color: Colors.black),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(AppAssets.qqIcon)),
            const SizedBox(width: 40),
            Image(image: AssetImage(AppAssets.weixinIcon)),
            const SizedBox(width: 40),
            Image(image: AssetImage(AppAssets.weiboIcon)),
          ],
        ),
      ],
    );
  }
}
