import 'package:flutter/material.dart';

// ignore: must_be_immutable
class searchtextfield extends StatefulWidget {
  String hinttext;
  TextEditingController search;
  String? searchText;
  searchtextfield(
      {super.key,
      required this.hinttext,
      required this.search,
      this.searchText});

  @override
  State<searchtextfield> createState() => _searchtextfieldState();
}

class _searchtextfieldState extends State<searchtextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    widget.searchText = value.toLowerCase();
                  });
                },
                controller: widget.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hinttext,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
