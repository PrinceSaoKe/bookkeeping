import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/bean/search_bill_bean.dart';
import 'package:bookkeeping/customed_widgets/customed_cards.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:bookkeeping/customed_widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  SearchBillBean searchBean = Get.arguments['bean'];
  bool needSearchBar = Get.arguments['need_search_bar'] ?? true;

  @override
  Widget build(BuildContext context) {
    if (searchBean.dayList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('无结果', style: TextStyle(fontSize: 20)),
        ),
      );
    }
    return Scaffold(
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.builder(
          itemCount: needSearchBar
              ? searchBean.dayList.length + 1
              : searchBean.dayList.length,
          itemBuilder: (context, index) {
            if (index == 0 && needSearchBar) {
              return GestureDetector(
                onTap: () {
                  Get.back();
                  Get.back();
                  Get.toNamed(AppRouter.search);
                },
                child: SearchBar(
                  enabled: false,
                  onTap: () {
                    Get.back();
                    Get.back();
                    Get.toNamed(AppRouter.search);
                  },
                ),
              );
            }
            if (!needSearchBar) {
              return SearchBill(
                time: DateTime.parse(searchBean.dayList[index].date),
                pay: searchBean.dayList[index].expend,
                income: searchBean.dayList[index].income,
                bean: searchBean.dayList[index],
              );
            }
            return SearchBill(
              time: DateTime.parse(searchBean.dayList[index - 1].date),
              pay: searchBean.dayList[index - 1].expend,
              income: searchBean.dayList[index - 1].income,
              bean: searchBean.dayList[index - 1],
            );
          },
        ),
      ),
    );
  }
}
