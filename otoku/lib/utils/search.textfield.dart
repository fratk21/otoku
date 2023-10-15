import 'package:flutter/material.dart';

// ignore: must_be_immutable
class searchtextfield extends StatefulWidget {
  String hinttext;
  searchtextfield({super.key, required this.hinttext});

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
          borderRadius: BorderRadius.circular(10), // Radiuslu olacak
          border:
              Border.all(color: Colors.black, width: 1), // İnce ve siyah border
        ),
        child: Row(
          children: [
            Icon(Icons.search), // Büyüteç ikonu
            SizedBox(width: 10), // İkon ile metin arasındaki boşluk
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none, // Dışarıdaki border'ı kaldır
                  hintText: widget.hinttext, // Varsayılan metin
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
