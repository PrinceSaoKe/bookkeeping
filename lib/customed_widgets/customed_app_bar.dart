import 'package:bookkeeping/app_theme.dart';
import 'package:flutter/material.dart';

class CustomedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomedAppBar(
    this.title, {
    super.key,
    this.height = kToolbarHeight,
    this.centerTitle = false,
    this.actions,
  });

  final double height;
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      foregroundColor: AppTheme.darkGold,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height);
}
