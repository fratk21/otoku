import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otoku/pages/home/screen/product.details.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:otoku/widgets/appbarmodel.dart';

class Product {
  final String productName;
  final List<dynamic> likes;
  final String price;

  Product({
    required this.productName,
    required this.likes,
    required this.price,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] ?? '',
      likes: (map['likes'] as List<dynamic>?) ?? [],
      price: map["price"].toString() ?? "",
    );
  }
}

class UserLikedProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userUid = FirebaseAuth.instance.currentUser?.uid ?? "";

    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.white,
        title: Text(
          "OTOKU Favorite",
          style: TextStyle(
            fontFamily: "BlackOpsOne",
            fontSize: 30,
            color: AppColors.orange,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> products = snapshot.data!.docs;

          List<Product> likedProducts = products
              .map((product) =>
                  Product.fromMap(product.data() as Map<String, dynamic>))
              .where((product) => product.likes.contains(userUid))
              .toList();

          return ListView.builder(
            itemCount: likedProducts.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  PageNavigator.push(
                      context, productdetailscreen(snap: products[index]));
                },
                title: Text(likedProducts[index].productName),
                trailing: Text(likedProducts[index].price),
              );
            },
          );
        },
      ),
    );
  }
}
