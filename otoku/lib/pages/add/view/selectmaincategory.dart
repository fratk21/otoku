import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/model/json_data.dart';

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

// ignore: must_be_immutable
class SubSubCategoriesPage extends StatelessWidget {
  final List<dynamic> subSubcategories;
  String subcategory;

  SubSubCategoriesPage(
      {required this.subSubcategories, required this.subcategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${this.subcategory} Alt Kategoriler"),
      ),
      body: ListView(
        children: subSubcategories.map<Widget>((subSubcategory) {
          return ListTile(
            trailing: Icon(CupertinoIcons.right_chevron),
            title: Text(subSubcategory),
          );
        }).toList(),
      ),
    );
  }
}

class SubCategoriesPage extends StatelessWidget {
  final Map<String, dynamic> category;

  SubCategoriesPage({required this.category});

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
              onTap: () {},
            );
          } else if (subcategory is Map<String, dynamic>) {
            return ListTile(
              trailing: Icon(CupertinoIcons.right_chevron),
              title: Text(subcategory["subcategory_name"]),
              onTap: () {
                final subSubcategories = subcategory["subcategories"];
                if (subSubcategories is List) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubSubCategoriesPage(
                        subSubcategories: subSubcategories,
                        subcategory: subcategory["subcategory_name"],
                      ),
                    ),
                  );
                }
              },
            );
          }
          return SizedBox.shrink(); // Hatalı veri tipi ise görmezden gel
        }).toList(),
      ),
    );
  }
}
