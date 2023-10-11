import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/bean/universal_bean.dart';
import 'package:bookkeeping/customed_widgets/alert_dialog.dart';
import 'package:bookkeeping/customed_widgets/customed_button.dart';
import 'package:bookkeeping/my/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController teleCtrller = TextEditingController();
  TextEditingController userNameCtrller = TextEditingController();
  TextEditingController passwordCtrller1 = TextEditingController();
  TextEditingController passwordCtrller2 = TextEditingController();
  TextEditingController pinCtrller = TextEditingController();
  bool agreeCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: ListView(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 55),
          children: [
            Image.asset(AppAssets.logo, width: 200, height: 200),
            const SizedBox(height: 10),
            LoginTextField(
              controller: teleCtrller,
              hintText: '请输入手机号',
              icon: const Icon(Icons.smartphone, color: Colors.white),
              suffix: LoginButton(
                text: '获取验证码',
                textColor: AppTheme.darkGold,
                size: const Size(90, 30),
                fontSize: 11,
                onTap: () async {
                  UniversalBean bean =
                      await AppNet.sendPin(tele: teleCtrller.text);
                  await alertDialog(
                    context,
                    title: bean.status == 200 ? '成功！' : '失败！',
                    text: bean.message ?? '未知错误',
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            LoginTextField(
              controller: userNameCtrller,
              hintText: '请输入昵称',
              icon: const Icon(Icons.account_circle_outlined,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            LoginTextField(
              controller: passwordCtrller1,
              hintText: '请输入密码',
              hideText: true,
              icon: const Icon(Icons.lock_open, color: Colors.white),
            ),
            const SizedBox(height: 20),
            LoginTextField(
              controller: passwordCtrller2,
              hintText: '请再次输入密码',
              hideText: true,
              icon: const Icon(Icons.lock_outline, color: Colors.white),
            ),
            const SizedBox(height: 20),
            LoginTextField(
              controller: pinCtrller,
              hintText: '请输入验证码',
              icon: const Icon(Icons.pin_outlined, color: Colors.white),
            ),
            const SizedBox(height: 10),
            getCheckBox(),
            const SizedBox(height: 10),
            LoginButton(
              text: '注   册',
              onTap: () async {
                UniversalBean bean = await AppNet.register(
                  tele: teleCtrller.text,
                  userName: userNameCtrller.text,
                  password: passwordCtrller1.text,
                  password2: passwordCtrller2.text,
                  pin: pinCtrller.text,
                );
                alertDialog(
                  context,
                  title: bean.status == 201 ? '成功！' : '失败！',
                  text: bean.message ?? '未知错误',
                );
                if (bean.status == 201) Get.back();
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget getCheckBox() {
    return Row(
      children: [
        Checkbox(
          value: agreeCheck,
          activeColor: AppTheme.themeColor,
          checkColor: AppTheme.darkGold,
          shape: const CircleBorder(side: BorderSide(color: AppTheme.darkGold)),
          onChanged: (value) {
            agreeCheck = !agreeCheck;
            setState(() {});
          },
        ),
        const Text(
          '我已阅读使用条款和隐私政策',
          style: TextStyle(
            color: AppTheme.darkGold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
