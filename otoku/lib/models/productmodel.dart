import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/productdeails.dart';
import 'package:otoku/utils/colors.dart';

class productmodel extends StatefulWidget {
  const productmodel({super.key});

  @override
  State<productmodel> createState() => _productmodelState();
}

class _productmodelState extends State<productmodel> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => productdetailscreen(),
                ));
          },
          onDoubleTap: () {
            setState(() {
              favorite == false ? favorite = true : favorite = false;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Radiuslu olacak
              border:
                  Border.all(color: gblue, width: 1.3), // İnce ve siyah border
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    child: Image.asset(
                      "assets/image/dress.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "1.50000 TL",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "daire boyama dskmfdsölfösfdçşdsfmödsfçşfds",
                    overflow: TextOverflow
                        .ellipsis, // Metin kesildiğinde "..." ile göster
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'şehir, ülke',
                    overflow: TextOverflow
                        .ellipsis, // Metin kesildiğinde "..." ile göster
                    maxLines: 1, // Metin sadece bir satırda gösterilsin
                    style: TextStyle(color: black),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 0, // Yatayda üst kenara yapışık
            right: 0, // Dikeyde sağ kenara yapışık
            child: Center(
              child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    setState(() {
                      favorite == false ? favorite = true : favorite = false;
                    });
                  },
                  icon: Icon(
                    favorite!
                        ? CupertinoIcons.heart
                        : CupertinoIcons.heart_fill,
                    color: orange,
                  )),
            )),
      ],
    );
  }
}
