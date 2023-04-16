import 'package:flutter/material.dart';

class AppTools {
  static Size getDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static showPopup(
    BuildContext context, {
    required Widget widget,
    bool barrierDismissible = true, // 点击灰色背景的时候是否消失弹出框
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return widget;
      },
    );
  }

  /// 4.2
  static String toMonDotDay(DateTime time) {
    return '${time.month}.${time.day}';
  }

  /// 2023-04-02
  static String toY0M0D(DateTime time) {
    String text = '${time.year}';
    if (time.month < 10) {
      text += '-0${time.month}';
    } else {
      text += '-${time.month}';
    }
    if (time.day < 10) {
      text += '-0${time.day}';
    } else {
      text += '-${time.day}';
    }
    return text;
  }

  /// 日
  static String toDayOfWeek(DateTime time) {
    switch (time.weekday) {
      case 1:
        return '一';
      case 2:
        return '二';
      case 3:
        return '三';
      case 4:
        return '四';
      case 5:
        return '五';
      case 6:
        return '六';
      case 7:
        return '日';
      default:
        return '';
    }
  }

  /// 07:09
  static String to0Hour0Min(DateTime time) {
    String text = '';
    if (time.hour < 10) text += '0';
    text += '${time.hour}:';
    if (time.minute < 10) text += '0';
    text += '${time.minute}';
    return text;
  }

  /// 07:09，用TimeOfDay
  static String to0Hour0MinTime(TimeOfDay time) {
    String text = '';
    if (time.hour < 10) text += '0';
    text += '${time.hour}:';
    if (time.minute < 10) text += '0';
    text += '${time.minute}';
    return text;
  }
}
