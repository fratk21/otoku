import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/models/appbarmodel.dart';
import 'package:otoku/models/pagemodel.dart';
import 'package:otoku/models/productmodel.dart';
import 'package:otoku/provider/locationprovider.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/indicator.dart';
import 'package:provider/provider.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

class productscreen extends StatefulWidget {
  const productscreen({super.key});

  @override
  State<productscreen> createState() => _productscreenState();
}

class _productscreenState extends State<productscreen>
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
    final locationProvider = Provider.of<LocationProvider>(context);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_city_rounded,
                color: black,
              ), // İkon
              SizedBox(width: 8.0), // İkon ile metin arasında boşluk
              Container(
                width: 100,
                child: Text(
                  '${locationProvider.country}',
                  overflow: TextOverflow
                      .ellipsis, // Metin kesildiğinde "..." ile göster
                  maxLines: 1, // Metin sadece bir satırda gösterilsin
                  style: TextStyle(color: gblue),
                ),
              ),
            ],
          ),
        ],
        preferredSizeWidget: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Radiuslu olacak
                  border: Border.all(
                      color: Colors.black, width: 1), // İnce ve siyah border
                ),
                child: Row(
                  children: [
                    Icon(Icons.search), // Büyüteç ikonu
                    SizedBox(width: 10), // İkon ile metin arasındaki boşluk
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border:
                              InputBorder.none, // Dışarıdaki border'ı kaldır
                          hintText: 'Arama yapın...', // Varsayılan metin
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
              SingleChildScrollView(
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
              ),
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
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this would produce 2 rows.
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                // Generate 100 Widgets that display their index in the List
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

class category extends StatefulWidget {
  final String name;
  final String image;
  final Function() function;
  const category(
      {super.key,
      required this.function,
      required this.image,
      required this.name});

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Kategoriye tıklandığında yapılacak işlemleri burada tanımlayabilirsiniz.
        // Örneğin, ilgili sayfaya yönlendirme işlemi yapabilirsiniz.
        widget.function();
      },
      child: Column(
        children: [
          Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Yuvarlak şekil
                // Yuvarlak alanın arka plan rengi
              ),
              child: Center(child: Image.asset(widget.image))),
          SizedBox(height: 10), // Yuvarlak alan ile açıklama arasındaki boşluk
          Text(
            widget.name, // Kategori adı
            style: TextStyle(
              fontWeight: FontWeight.bold, // Kalın metin
            ),
          ),
        ],
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
