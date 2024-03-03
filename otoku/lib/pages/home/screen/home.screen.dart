import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/model/json_data.dart';
import 'package:otoku/pages/add/addProduct/view/selectmaincategory.dart';
import 'package:otoku/pages/favorite/view.dart';
import 'package:otoku/services/location.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/pages/home/viewmodel/category.model.dart';
import 'package:otoku/pages/home/viewmodel/productmodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/indicator.dart';
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
  TextEditingController search = TextEditingController();
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
    return PageModel(
        appBar: CustomAppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          title: Text(
            "OTOKU FORUM",
            style: TextStyle(
              fontFamily: "BlackOpsOne",
              fontSize: 30,
              color: AppColors.orange,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  PageNavigator.push(context, UserLikedProductsPage());
                },
                icon: Icon(Icons.favorite, color: Colors.red))
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
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
                          setState(() {});
                        },
                        controller: search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ürünlerde arama yapın...',
                        ),
                      ),
                    ),
                    if (search.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          search.clear();
                          Future.delayed(Duration(milliseconds: 100), () {
                            setState(() {});
                          });
                        },
                        child: Icon(Icons.clear),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: _bodyhome(context));
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
          FutureBuilder<Map<String, String>?>(
            future: getUserLocationInfo(context),
            builder: (context, locationSnapshot) {
              if (locationSnapshot.connectionState == ConnectionState.waiting) {
                return CustomProgressIndicator();
              } else if (locationSnapshot.hasError) {
                return Text('Error: ${locationSnapshot.error}');
              } else {
                Map<String, String>? locationInfo = locationSnapshot.data;
                String userCountry = locationInfo?['country'] ?? 'Bilinmiyor';

                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('products')
                      .where('country', isEqualTo: userCountry)
                      .get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<DocumentSnapshot> products = snapshot.data!.docs;

                      List<DocumentSnapshot> filteredProducts = products
                          .where((product) =>
                              product['productName']
                                  .toLowerCase()
                                  .contains(search.text.toLowerCase()) ||
                              product['productDescription']
                                  .toLowerCase()
                                  .contains(search.text.toLowerCase()))
                          .toList();

                      return GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children:
                            List.generate(filteredProducts.length, (index) {
                          return productmodel(
                            snap: filteredProducts[index].data(),
                          );
                        }),
                      );
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

AppBar _appbar() {
  TextEditingController search = TextEditingController();
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
          search: search,
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
    PageNavigator.push(
        context,
        SubCategoriesPage(
          category: foundCategory,
          add: false,
        ));
  } else {
    print('Kategori bulunamadı.');
  }
}
