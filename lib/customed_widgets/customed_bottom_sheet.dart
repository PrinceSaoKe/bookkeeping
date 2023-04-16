import 'package:bookkeeping/app_theme.dart';
import 'package:flutter/material.dart';

customedButtomSheet(BuildContext context) {
  showBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.camera_alt_outlined,
              color: AppTheme.themeColor,
            ),
            title: const Text('拍摄照片'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.image_outlined,
              color: AppTheme.themeColor,
            ),
            title: const Text('选取图片'),
            onTap: () {},
          ),
        ],
      );
    },
  );
}
