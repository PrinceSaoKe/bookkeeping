import 'package:bookkeeping/addons/device_calendar.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/customed_widgets/alert_dialog.dart';
import 'package:bookkeeping/customed_widgets/customed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime now = DateTime.now();
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomedAppBar('日历'),
      backgroundColor: const Color(0xFFF5F5F5),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.orangeTheme,
        child: const Icon(Icons.add),
        onPressed: () {
          String title = '';
          String money = '';
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('添加日程'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Text('日程：'),
                        Expanded(
                          child: TextField(
                            onChanged: (text) {
                              title = text;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text('金额：'),
                        Expanded(
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]')),
                            ],
                            onChanged: (text) {
                              money = text;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text("取消"),
                    onPressed: () {
                      Navigator.pop(context, 'Cancle');
                    },
                  ),
                  TextButton(
                    child: const Text("确定"),
                    onPressed: () {
                      Navigator.pop(context, "Ok");

                      addEventToCalendar(
                        title: '$title（金额：$money）',
                        start: selected,
                      );
                      alertDialog(
                        context,
                        title: '成功！',
                        text: '日程已成功添加到系统日历中，日程当天系统将会提醒您',
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(overscroll: false),
            child: ListView(
              shrinkWrap: true,
              children: [
                // 日历
                CalendarDatePicker(
                  initialDate: now,
                  firstDate: DateTime(2000, 1, 1),
                  lastDate: DateTime(2050, 1, 1),
                  onDateChanged: (time) {
                    selected = time;
                  },
                ),
                const Divider(),
                // 当日数据
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: 0.8,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        getLabelText('月收入'),
                        const SizedBox(height: 5),
                        getNumText('1243.08'),
                        const SizedBox(height: 20),
                        getLabelText('日收入'),
                        const SizedBox(height: 5),
                        getNumText('0.00'),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        getLabelText('月支出'),
                        const SizedBox(height: 5),
                        getNumText('243.08'),
                        const SizedBox(height: 20),
                        getLabelText('日支出'),
                        const SizedBox(height: 5),
                        getNumText('41.00'),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        getLabelText('月结余'),
                        const SizedBox(height: 5),
                        getNumText('100.00'),
                        const SizedBox(height: 20),
                        getLabelText('日结余'),
                        const SizedBox(height: 5),
                        getNumText('-41.00'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text getLabelText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, color: Color(0xFF707070)),
    );
  }

  Text getNumText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, color: Color(0xFF000000)),
    );
  }
}
