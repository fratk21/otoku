import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/model/json_data.dart';
import 'package:otoku/pages/add/view/selectmaincategory.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/pages/home/viewmodel/category.model.dart';
import 'package:otoku/pages/home/viewmodel/productmodel.dart';

import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/search.textfield.dart';

import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

final Map<String, dynamic> jsonData = categoryData;

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
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageModel(appBar: _appbar(), body: _bodyhome(context));
  }
}

AppBar _appbar() {
  return CustomAppBar(
    centerTitle: false,
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.white,
    title: Text(
      "OTOKU",
      style: TextStyle(
          fontFamily: "BlackOpsOne", fontSize: 30, color: AppColors.orange),
    ),
    actions: [IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell))],
    bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: searchtextfield(
          hinttext: 'Arama yapın...',
        )),
  );
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

Widget _categorys(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        category(
          function: () {
            final Map<String, dynamic>? foundCategory =
                findCategoryByName("Manga");
            categorycontrol(foundCategory, context);
          },
          image: "assets/image/manga.png",
          name: "manga",
        ),
        SizedBox(
          width: 30,
        ),
        category(
          function: () {
            final Map<String, dynamic>? foundCategory =
                findCategoryByName("Çizgi Roman");
            categorycontrol(foundCategory, context);
          },
          image: "assets/image/cr.png",
          name: "Çizgi Roman",
        ),
        SizedBox(
          width: 30,
        ),
        category(
          function: () {
            final Map<String, dynamic>? foundCategory =
                findCategoryByName("Figür");
            categorycontrol(foundCategory, context);
          },
          image: "assets/image/figur.png",
          name: "Figur",
        ),
        SizedBox(
          width: 30,
        ),
        category(
          function: () {
            final Map<String, dynamic>? foundCategory =
                findCategoryByName("Cosplay Kıyafetleri");
            categorycontrol(foundCategory, context);
          },
          image: "assets/image/cosplay.png",
          name: "Cosplay",
        ),
        SizedBox(
          width: 30,
        ),
        category(
          function: () {
            final Map<String, dynamic>? foundCategory =
                findCategoryByName("Gündelik Kıyafetler");
            categorycontrol(foundCategory, context);
          },
          image: "assets/image/dress.png",
          name: "Wear",
        ),
        SizedBox(
          width: 30,
        ),
        category(
          function: () {
            final Map<String, dynamic>? foundCategory =
                findCategoryByName("Diğer");
            categorycontrol(foundCategory, context);
          },
          image: "assets/image/other.png",
          name: "other",
        ),
      ],
    ),
  );
}

Map<String, dynamic>? findCategoryByName(String categoryNameToFind) {
  final List<dynamic> categories = jsonData['categories'];
  Map<String, dynamic>? foundCategory;

  for (final category in categories) {
    if (category['category_name'] == categoryNameToFind) {
      foundCategory = category;
      break;
    }
  }

  return foundCategory;
}

void categorycontrol(foundCategory, BuildContext context) {
  if (foundCategory != null) {
    PageNavigator.push(context, SubCategoriesPage(category: foundCategory));
  } else {
    print('Kategori bulunamadı.');
  }
}

Widget _bodyhome(BuildContext context) {
  final List<String> _images = [
    'assets/image/manga.png',
    'assets/image/manga.png',
    'assets/image/manga.png',
    'assets/image/manga.png',
  ];

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

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 164,
          child: ScrollPageView(
            controller: ScrollPageController(),
            children: _images.map((image) => _imageView(image)).toList(),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Category",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        _categorys(context),
        SizedBox(height: 20),
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
        SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(10, (index) {
            // İlan öğelerini burada ekleyin
            return productmodel();
          }),
        ),
      ],
    ),
  );
}
