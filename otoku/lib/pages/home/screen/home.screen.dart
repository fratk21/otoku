import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/widgets/pagemodel.dart';
import 'package:otoku/pages/home/viewmodel/category.model.dart';
import 'package:otoku/pages/home/viewmodel/productmodel.dart';

import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/search.textfield.dart';

import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(); // Animasyonu sürekli olarak tekrarlayın.
  }

  @override
  void dispose() {
    _controller.dispose(); // Sayfa kapatıldığında controller'ı temizleyin.
    super.dispose();
  }

  static const _images = [
    'assets/image/manga.png',
    'assets/image/manga.png',
    'assets/image/manga.png',
    'assets/image/manga.png',
  ];

  @override
  Widget build(BuildContext context) {
    return pagemodel(
      AppBar: CustomAppBar(
        height: 120,
        centerTitle: false,
        autoleading: false,
        backgroundColor: white,
        title: Text(
          "OTOKU",
          style:
              TextStyle(fontFamily: "BlackOpsOne", fontSize: 30, color: orange),
        ),
        actions: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.location_city_rounded,
          //       color: black,
          //     ), // İkon
          //     SizedBox(width: 8.0), // İkon ile metin arasında boşluk
          //     Container(
          //       width: 100,
          //       child: Text(
          //         'Türkiye',
          //         overflow: TextOverflow
          //             .ellipsis, // Metin kesildiğinde "..." ile göster
          //         maxLines: 1, // Metin sadece bir satırda gösterilsin
          //         style: TextStyle(color: gblue),
          //       ),
          //     ),
          //   ],
          // ),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell))
        ],
        preferredSizeWidget: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: searchtextfield(
              hinttext: 'Arama yapın...',
            )),
      ),
      Widget: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 164,
                child: ScrollPageView(
                  controller: ScrollPageController(),
                  children: _images.map((image) => _imageView(image)).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Category",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _categorys(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Güncel ilanlar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(10, (index) {
                  return productmodel();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _imageView(String image) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Card(
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    ),
  );
}

Widget _categorys() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        category(
          function: () {},
          image: "assets/image/manga.png",
          name: "manga",
        ),
        SizedBox(
          width: 30,
        ),
        category(
          function: () {},
          image: "assets/image/figur.png",
          name: "figur",
        ),
        SizedBox(
          width: 30,
        ),
        category(
          function: () {},
          image: "assets/image/dress.png",
          name: "dress",
        ),
        SizedBox(
          width: 30,
        ),
        category(
          function: () {},
          image: "assets/image/other.png",
          name: "other",
        ),
      ],
    ),
  );
}
