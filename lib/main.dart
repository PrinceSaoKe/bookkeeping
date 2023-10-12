import 'package:bookkeeping/app_data.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  AppData().initData();
  await AppNet.getBaseURL();
  print('-------------mainprintbaseURL----------------------------');
  print(AppNet.baseURL);
  print('-------------结束----------------------------');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Get.deviceLocale,
      translations: Messages(),
      debugShowCheckedModeBanner: false,
      title: '布奇',
      theme: AppTheme.themeData,
      initialRoute:
          AppData().currUserID == null ? AppRouter.login : AppRouter.root,
      getPages: AppRouter.router,
    );
  }
}
