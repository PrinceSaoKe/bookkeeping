import 'package:bookkeeping/app_data.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/app_tools.dart';
import 'package:bookkeeping/bean/search_bill_bean.dart';
import 'package:bookkeeping/customed_widgets/customed_button.dart';
import 'package:bookkeeping/customed_widgets/customed_search_bar.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<DateTime?> dateRange = [null, null];
  List<double?> moneyRange = [null, null];
  TextEditingController controller = TextEditingController();
  List<String> subtype = [];
  String type = 'expend';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView(
          children: [
            CustomedSearchBar(
              controller: controller,
              onTap: () async {
                // print(AppData().currUserID);
                // print(controller.text);
                // print(type);
                // print(subtype);
                // print(dateRange[0]);
                // print(dateRange[1]);
                // print(moneyRange[0]);
                // print(moneyRange[1]);
                SearchBillBean bean = await AppNet.search(
                  userID: AppData().currUserID!,
                  searchString: controller.text,
                  type: type,
                  subtype: subtype,
                  startTime: dateRange[0],
                  endTime: dateRange[1],
                  minMoney: moneyRange[0],
                  maxMoney: moneyRange[1],
                );
                Get.toNamed(AppRouter.searchResult, arguments: {'bean': bean});
              },
            ),
            getLabelText('收支类型'),
            Container(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: GridView.extent(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                maxCrossAxisExtent: 120,
                childAspectRatio: 2,
                children: [
                  CustomedOptionButton(
                    text: '支出',
                    onTap: () {
                      if (type == 'earning') subtype.clear();
                      type = 'expend';
                      setState(() {});
                    },
                    isSelect: type == 'expend' ? true : false,
                  ),
                  CustomedOptionButton(
                    text: '收入',
                    onTap: () {
                      if (type == 'expend') subtype.clear();
                      type = 'earning';
                      setState(() {});
                    },
                    isSelect: type == 'earning' ? true : false,
                  ),
                ],
              ),
            ),
            getLabelText('时间区间'),
            Container(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: Row(
                children: [
                  getPickerOption(
                    context: context,
                    text: dateRange[0] == null
                        ? '起始日期'
                        : AppTools.toY0M0D(dateRange[0]!),
                    index: 0,
                  ),
                  Container(width: 30, height: 2, color: AppTheme.lightGreen),
                  getPickerOption(
                    context: context,
                    text: dateRange[1] == null
                        ? '结束日期'
                        : AppTools.toY0M0D(dateRange[1]!),
                    index: 1,
                  ),
                ],
              ),
            ),
            getLabelText(type == 'expend' ? '消费类型' : '收入类型'),
            if (type == 'expend')
              Container(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: GridView.extent(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  maxCrossAxisExtent: 120,
                  childAspectRatio: 2,
                  children: [
                    getOptionButton(label: '餐饮', para: '餐饮'),
                    getOptionButton(label: '娱乐', para: '娱乐'),
                    getOptionButton(label: '居家', para: '居家'),
                    getOptionButton(label: '文化教育', para: '文化教育'),
                    getOptionButton(label: '交通', para: '交通'),
                    getOptionButton(label: '办公', para: '办公'),
                    getOptionButton(label: '运动', para: '运动'),
                    getOptionButton(label: '服装', para: '服装'),
                    getOptionButton(label: '医疗', para: '医疗'),
                    getOptionButton(label: '购物', para: '购物'),
                    getOptionButton(label: '宠物', para: '宠物'),
                    getOptionButton(label: '其他', para: '其他'),
                  ],
                ),
              ),
            if (type == 'earning')
              Container(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: GridView.extent(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  maxCrossAxisExtent: 120,
                  childAspectRatio: 2,
                  children: [
                    getOptionButton(label: '工资', para: '工资'),
                    getOptionButton(label: '打工', para: '打工'),
                    getOptionButton(label: '奖金', para: '奖金'),
                    getOptionButton(label: '其他', para: '其他'),
                  ],
                ),
              ),
            getLabelText('金额筛选'),
            Container(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: Row(
                children: [
                  getInputOption(
                    context: context,
                    text: moneyRange[0] == null
                        ? '最低价'
                        : moneyRange[0]!.toStringAsFixed(2),
                    index: 0,
                  ),
                  Container(width: 30, height: 2, color: AppTheme.lightGreen),
                  getInputOption(
                    context: context,
                    text: moneyRange[1] == null
                        ? '最高价'
                        : moneyRange[1]!.toStringAsFixed(2),
                    index: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget getOptionButton(
      {required String label, required String para, bool isSelect = false}) {
    return CustomedOptionButton(
      text: label,
      onTap: () {
        if (subtype.contains(para)) {
          subtype.remove(para);
        } else {
          subtype.add(para);
        }
      },
      isSelect: isSelect,
    );
  }

  Widget getLabelText(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  Widget getPickerOption(
      {required BuildContext context,
      required String text,
      required int index}) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          fixedSize: const Size(120, 43),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: AppTheme.lightGrey),
        ),
        onPressed: () async {
          dateRange[index] = await showDatePicker(
            context: context,
            initialDate:
                dateRange[index] == null ? DateTime.now() : dateRange[index]!,
            firstDate: DateTime(2000, 1, 1),
            lastDate: DateTime(2050, 1, 1),
          );
          setState(() {});
        },
      ),
    );
  }

  Widget getInputOption(
      {required BuildContext context,
      required String text,
      required int index}) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          fixedSize: const Size(120, 43),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: const TextStyle(color: AppTheme.lightGrey),
          ),
          onChanged: (str) {
            moneyRange[index] = double.tryParse(str);
          },
        ),
        onPressed: () {},
      ),
    );
  }
}
