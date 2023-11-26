import 'package:flutter/material.dart';
import 'package:otoku/pages/home/viewmodel/productmodel.dart';
import 'package:otoku/widgets/appbarmodel.dart';

class productsScreen extends StatefulWidget {
  final Map<String, dynamic> category;

  final String subcategory;
  const productsScreen({
    super.key,
    required this.category,
    required this.subcategory,
  });

  @override
  State<productsScreen> createState() => _productsScreenState();
}

class _productsScreenState extends State<productsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        "${widget.category['category_name']} --> ${widget.subcategory}"),
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
          ),
        ),
      ),
    );
  }
}
