import 'package:bookkeeping/app_theme.dart';
import 'package:flutter/material.dart';

/// 首页搜索框
class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    this.enabled = true,
    this.onTap,
    this.controller,
    this.onTapScanner,
  });

  final bool enabled;
  final Function? onTap;
  final TextEditingController? controller;
  final Function? onTapScanner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          // 输入框
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.themeColor, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(44)),
                ),
                child: Row(
                  children: [
                    // TextField
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: TextField(
                          enabled: enabled,
                          controller: controller,
                          style: const TextStyle(fontSize: 18),
                          cursorColor: AppTheme.themeColor,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '搜索...',
                          ),
                        ),
                      ),
                    ),
                    // 搜索按钮
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        onTap: () {
                          if (onTap != null) onTap!();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.search, color: AppTheme.themeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 扫码按钮
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            onTap: () async {
              if (onTapScanner != null) onTapScanner!();
            },
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                // Icons.crop_free,
                Icons.camera_alt_outlined,
                size: 35,
                color: AppTheme.themeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
