import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppRouter.rootPage[_currentIndex],
      // 记账按钮
      floatingActionButton: Container(
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.only(top: 20),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(250, 250, 250, 1),
        ),
        child: FloatingActionButton(
          backgroundColor: AppTheme.orangeTheme,
          onPressed: () {
            // Get.toNamed(AppRouter.cropImage, arguments: {'image': null});
            Get.toNamed(AppRouter.addBill);
          },
          child: const Icon(Icons.add, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.themeColor,
        selectedFontSize: 12.0,
        onTap: (index) {
          setState(() {
            if (index == 2) return;
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '报表'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: '计划'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
