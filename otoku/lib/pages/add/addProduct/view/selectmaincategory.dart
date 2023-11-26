import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/model/json_data.dart';
import 'package:otoku/pages/add/addProduct/view/add_product.dart';
import 'package:otoku/pages/products/screen/products.dart';
import 'package:otoku/utils/pageroutes.dart';

class MainCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Kategoriler"),
      ),
      body: ListView(
        children: categoryData["categories"].map<Widget>((category) {
          final String categoryName = category["category_name"];
          return ListTile(
            trailing: Icon(CupertinoIcons.right_chevron),
            title: Text(categoryName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCategoriesPage(
                    category: category,
                    add: true,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class SubCategoriesPage extends StatelessWidget {
  final Map<String, dynamic> category;
  final bool add;

  SubCategoriesPage({required this.category, required this.add});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> subcategories = category["subcategories"];
    final String categoryName = category["category_name"];

    return Scaffold(
      appBar: AppBar(
        title: Text("$categoryName Alt Kategoriler"),
      ),
      body: ListView(
        children: subcategories.map<Widget>((subcategory) {
          if (subcategory is String) {
            return ListTile(
              trailing: Icon(CupertinoIcons.right_chevron),
              title: Text(subcategory),
              onTap: () {
                print("object");
              },
            );
          } else if (subcategory is Map<String, dynamic>) {
            return ListTile(
              trailing: Icon(CupertinoIcons.right_chevron),
              title: Text(subcategory["subcategory_name"]),
              onTap: () {
                if (add == false) {
                  PageNavigator.push(
                      context,
                      productsScreen(
                        category: category,
                        subcategory: subcategory["subcategory_name"],
                      ));
                } else {
                  PageNavigator.push(
                      context,
                      add_product_screen(
                          category: category,
                          subcategory: subcategory["subcategory_name"]));
                }
              },
            );
          }
          return SizedBox.shrink();
        }).toList(),
      ),
    );
  }
}
