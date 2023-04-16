import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/bean/bookkeeping_suggest_bean.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showBookkeepingSuggest(BuildContext context) async {
  BookkeepingSuggestBean bean =
      await AppNet.bookkeepingSuggest(dateTime: DateTime.now());
  return await showDialog(
    context: context,
    builder: (context2) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 250,
              height: 390,
              // color: Colors.red,
            ),
            Positioned(
              top: 10,
              right: 0,
              child: Container(
                width: 250,
                height: 350,
                decoration: BoxDecoration(
                  color: AppTheme.lightGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              right: 15,
              bottom: 0,
              child: Container(
                width: 250,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 100,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppTheme.themeColor,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Image.asset(AppAssets.whiteAvatar),
                ),
              ),
            ),
            Positioned(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '布奇建议',
                    style: TextStyle(
                      color: AppTheme.themeColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 220,
                    child: Text(
                      '        ${bean.suggestion}',
                      style: const TextStyle(
                          color: AppTheme.themeColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              child: ElevatedButton.icon(
                onPressed: () async {
                  Get.back();
                  showBookkeepingSuggest(context);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('换一换'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
