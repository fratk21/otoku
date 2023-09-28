import 'package:flutter/material.dart';
import 'package:otoku/utils/colors.dart';

class pagemodel extends StatefulWidget {
  final AppBar;
  final Widget;
  final FloatingActionButton? floatingActionButton;
  const pagemodel(
      {super.key,
      required this.AppBar,
      required this.Widget,
      this.floatingActionButton});

  @override
  State<pagemodel> createState() => _pagemodelState();
}

class _pagemodelState extends State<pagemodel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: flashwhite,
      appBar: widget.AppBar,
      body: widget.Widget,
      floatingActionButton: widget.floatingActionButton,
    ));
  }
}
