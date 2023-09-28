import 'package:flutter/material.dart';

class textmodel extends StatelessWidget {
  final String text;
  final bool style;
  final double? size;
  final bool bold;
  const textmodel(
      {super.key,
      required this.text,
      required this.style,
      this.size,
      required this.bold});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: style
              ? TextStyle(fontFamily: "BlackOpsOne", fontSize: size)
              : TextStyle(
                  fontSize: size,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
