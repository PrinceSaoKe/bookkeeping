import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/app_tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      body: GestureDetector(
        onTap: () {
          Get.toNamed(AppRouter.planDetail);
        },
        child: Container(
          color: AppTheme.themeColor,
          width: AppTools.getDeviceSize(context).width,
          height: AppTools.getDeviceSize(context).height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.logo2,
                  scale: 0.8,
                ),
                const SizedBox(height: 30),
                const Text(
                  '快来添加你的省钱计划吧！',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
