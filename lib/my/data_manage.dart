import 'package:bookkeeping/app_data.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/bean/search_bill_bean.dart';
import 'package:bookkeeping/customed_widgets/alert_dialog.dart';
import 'package:bookkeeping/customed_widgets/customed_app_bar.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataManagePage extends StatelessWidget {
  const DataManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomedAppBar('数据管理'),
      backgroundColor: const Color(0xFFF5F5F5),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            // 账单导入
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      '账单导入',
                      style: TextStyle(
                        color: AppTheme.lightGrey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('截图导入'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Excel/CSV导入'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('批量导入'),
                    trailing: const Icon(Icons.chevron_right),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    onTap: () {
                      alertDialog(
                        context,
                        title: '导入成功',
                        needCancle: true,
                        text: '请按照以下字段批量导入Excel表格：\n日期、商户、收支类型、票据类型、金额、内容、备注',
                      );
                    },
                  ),
                ],
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      '设置',
                      style: TextStyle(
                        color: AppTheme.lightGrey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('语种选择'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          color: AppTheme.themeColor,
                          child: Wrap(
                            children: [
                              ListTile(
                                title: const Text(
                                  '普通话',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  '闽南话',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  '粤语',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  '浙江话',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  '四川话',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  '上海话',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      '微信',
                      style: TextStyle(
                        color: AppTheme.lightGrey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('微信账单明细'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      SearchBillBean bean = await AppNet.search(
                        userID: AppData().currUserID!,
                        searchString: '',
                        type: 'expend',
                        subtype: null,
                        startTime: null,
                        endTime: null,
                        minMoney: null,
                        maxMoney: null,
                      );
                      Get.toNamed(
                        AppRouter.searchResult,
                        arguments: {'bean': bean, 'need_search_bar': false},
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('切换绑定账号'),
                    trailing: const Icon(Icons.chevron_right),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      '支付宝',
                      style: TextStyle(
                        color: AppTheme.lightGrey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('支付宝账单明细'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      SearchBillBean bean = await AppNet.search(
                        userID: AppData().currUserID!,
                        searchString: '',
                        type: 'expend',
                        subtype: null,
                        startTime: null,
                        endTime: null,
                        minMoney: null,
                        maxMoney: null,
                      );
                      Get.toNamed(
                        AppRouter.searchResult,
                        arguments: {'bean': bean, 'need_search_bar': false},
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('切换绑定账号'),
                    trailing: const Icon(Icons.chevron_right),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
