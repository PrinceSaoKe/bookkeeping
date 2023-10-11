import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/bean/exchange_rate_bean.dart';
import 'package:bookkeeping/customed_widgets/customed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeRatePage extends StatefulWidget {
  const ExchangeRatePage({super.key});

  @override
  State<ExchangeRatePage> createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends State<ExchangeRatePage> {
  double money = Get.arguments['money'];
  String country = Get.arguments['country'];
  late ExchangeRateBean bean;
  bool isLoading = true;
  int selected = 0;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    bean = await AppNet.exchangeRate(currCountry: country, currMoney: money);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomedAppBar(
        '汇率转换',
        actions: [
          GestureDetector(
            child: const Icon(Icons.check),
            onTap: () {
              Get.back(result: {
                'country': bean.list[selected].moneyType,
                'money': bean.list[selected].money,
              });
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: index == selected ? AppTheme.themeColor : null,
                    leading: Image.asset(
                      '${AppAssets.country}${bean.list[index].moneyTypeEnglish}.jpg',
                      width: 50,
                      height: 50,
                    ),
                    title: Text(
                      bean.list[index].moneyType,
                      style: index == selected
                          ? const TextStyle(color: Colors.white)
                          : null,
                    ),
                    trailing: Text(
                      '${bean.list[index].money}\n${bean.list[index].moneyTypeEnglish}',
                      textAlign: TextAlign.end,
                      style: index == selected
                          ? const TextStyle(color: Colors.white)
                          : null,
                    ),
                    onTap: () {
                      selected = index;
                      setState(() {});
                    },
                  );
                }),
      ),
    );
  }
}
