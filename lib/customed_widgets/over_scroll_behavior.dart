import 'package:flutter/material.dart';

// 取消ListView过度滑动的水波纹效果
class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      default:
        return GlowingOverscrollIndicator(
          // 不显示头部水波纹
          showLeading: false,
          // 不显示尾部水波纹
          showTrailing: false,

          axisDirection: axisDirection,
          color: Theme.of(context).colorScheme.secondary,
          child: child,
        );
    }
  }
}
