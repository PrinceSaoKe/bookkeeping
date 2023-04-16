import 'dart:io';

import 'package:bookkeeping/addons/image_picker.dart';
import 'package:bookkeeping/app_data.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/bean/home_data_bean.dart';
import 'package:bookkeeping/bean/total_mon_data_bean.dart';
import 'package:bookkeeping/customed_widgets/customed_cards.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:bookkeeping/customed_widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  late HomeDataBean bean;
  late TotalMonDataBean totalExpendBean;
  late TotalMonDataBean totalIncomeBean;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    if (AppData().currUserID == null) {
      Get.toNamed(AppRouter.login);
    }
    bean = await AppNet.getHomeData(
      userID: AppData().currUserID,
      date: DateTime.now(),
    );
    totalExpendBean = await AppNet.totalMonData(dateTime: DateTime.now());
    totalIncomeBean =
        await AppNet.totalMonData(dateTime: DateTime.now(), type: 'earning');

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // _initData();
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: RefreshIndicator(
                onRefresh: () async {
                  _getData();
                  setState(() {});
                },
                child: ListView.builder(
                  itemCount: bean.dayList.length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    // 搜索框
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouter.search);
                        },
                        child: SearchBar(
                          enabled: false,
                          onTap: () {
                            Get.toNamed(AppRouter.search);
                          },
                          onTapScanner: () {
                            Get.bottomSheet(
                              Container(
                                color: AppTheme.themeColor,
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      ),
                                      title: const Text(
                                        '拍摄照片',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () async {
                                        File? image = await takePhoto();
                                        Get.back();
                                        if (image != null) {
                                          Get.toNamed(
                                            AppRouter.cropImage,
                                            // 若未拍摄图片则参数为null
                                            arguments: {
                                              'image': image.path,
                                              'base64': null
                                            },
                                          );
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.image_outlined,
                                        color: Colors.white,
                                      ),
                                      title: const Text(
                                        '选取相册图片',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () async {
                                        File? image = await pickImage();
                                        Get.back();
                                        if (image != null) {
                                          Get.toNamed(AppRouter.cropImage,
                                              arguments: {
                                                'image': image.path,
                                                'base64': null,
                                              });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    // 首页汇总卡片
                    else if (index == 1) {
                      return HomeCard(
                        currExpend: totalExpendBean.currTotalMoney ?? 50.00,
                        currIncome: totalIncomeBean.currTotalMoney ?? 500.00,
                        currBalance: totalExpendBean.currMonBalance ?? 450.00,
                      );
                    } else {
                      return HomeBill(
                        time: bean.dayList[index - 2].date,
                        bean: bean.dayList[index - 2],
                        pay: bean.dayList[index - 2].expend,
                        income: bean.dayList[index - 2].earning,
                      );
                    }
                  },
                ),
              ),
            ),
    );
  }
}
