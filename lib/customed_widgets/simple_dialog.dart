import 'package:flutter/material.dart';

Future<String?> simpleDialog(BuildContext context, {String title = ''}) async {
  return await showDialog(
    barrierDismissible: true, //表示点击灰色背景的时候是否消失弹出框
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(title),
        children: <Widget>[
          SimpleDialogOption(
            child: const Text('小票'),
            onPressed: () {
              Navigator.pop(context, '小票');
            },
          ),
          const Divider(),
          SimpleDialogOption(
            child: const Text('火车票'),
            onPressed: () {
              Navigator.pop(context, '火车票');
            },
          ),
          const Divider(),
          SimpleDialogOption(
            child: const Text('其他'),
            onPressed: () {
              Navigator.pop(context, '其他');
            },
          ),
        ],
      );
    },
  );
}
