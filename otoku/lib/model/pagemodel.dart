import 'package:flutter/material.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/pading.dart';

class PageModel extends StatefulWidget {
  final AppBar? appBar;
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  PageModel({
    Key? key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  _PageModelState createState() => _PageModelState();
}

class _PageModelState extends State<PageModel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: widget.appBar,
        body: SingleChildScrollView(child: CustomPadding(child: widget.body)),
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}
