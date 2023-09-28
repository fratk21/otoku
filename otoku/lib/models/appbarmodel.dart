import 'package:flutter/material.dart';
import 'package:otoku/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color? backgroundColor;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final double? elevation;
  final double? height;
  final bool? autoleading;
  final PreferredSizeWidget? preferredSizeWidget;

  CustomAppBar(
      {Key? key,
      this.title,
      this.backgroundColor,
      this.leading,
      this.actions,
      this.centerTitle,
      this.elevation,
      this.height,
      this.autoleading,
      this.preferredSizeWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor ?? flashwhite,
      leading: leading,
      actions: actions,
      centerTitle: centerTitle ?? true,
      elevation: elevation ?? 0,
      automaticallyImplyLeading: autoleading ?? true,
      bottom: preferredSizeWidget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
