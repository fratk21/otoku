import 'package:flutter/material.dart';
import 'package:otoku/models/appbarmodel.dart';
import 'package:otoku/models/pagemodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import 'package:scroll_page_view/scroll_page.dart';

class productdetailscreen extends StatefulWidget {
  const productdetailscreen({super.key});

  @override
  State<productdetailscreen> createState() => _productdetailscreenState();
}

class _productdetailscreenState extends State<productdetailscreen> {
  static const _images = [
    'assets/image/manga.png',
    'assets/image/figur.png',
    'assets/image/other.png',
    'assets/image/konum.png',
  ];

  Widget build(BuildContext context) {
    return pagemodel(
        AppBar: CustomAppBar(
          elevation: 2,
          backgroundColor: Colors.transparent,
        ),
        Widget: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: ScrollPageView(
                    controller: ScrollPageController(),
                    children:
                        _images.map((image) => _imageView(image)).toList(),
                  ),
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "data",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.favorite_border))
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text("sasdsadsad"),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_city),
                            Text("şehir, ülke")
                          ],
                        ),
                        Text("21")
                      ],
                    )
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Detaylar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text("Durum"),
                        SizedBox(
                          width: 30,
                        ),
                        Text("yeni")
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text("kullanım"),
                        SizedBox(
                          width: 30,
                        ),
                        Text("2 yıl")
                      ],
                    ),
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Açıklama",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text("asdasdsa"),
                      ],
                    )
                  ],
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    print("mal");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("fırat"),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
                Divider()
              ],
            ),
          ),
        ));
  }
}

Widget _imageView(String image) {
  return ClipRRect(
    clipBehavior: Clip.antiAlias,
    borderRadius: BorderRadius.circular(8),
    child: Image.asset(image, fit: BoxFit.cover),
  );
}
