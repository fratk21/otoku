import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otoku/services/addproduct.services.dart';
import 'package:otoku/services/location.dart';

void addproductservicesControl(
  BuildContext context,
  String productname,
  String productdes,
  String productMoney,
  String state,
  List<Uint8List?> image,
  String maincategory,
  String subcategory,
) async {
  assert(productname.isNotEmpty, 'Ürün adı boş olamaz');
  assert(productdes.isNotEmpty, 'Ürün açıklaması boş olamaz');
  assert(productMoney.isNotEmpty, 'Ürün fiyatı boş olamaz');
  assert(state.isNotEmpty, 'Durum bilgisi boş olamaz');
  // assert(image.every((element) => element != null),
  //    'En az bir resim eklenmelidir');
  assert(maincategory.isNotEmpty, 'Ana kategori boş olamaz');
  assert(subcategory.isNotEmpty, 'Alt kategori boş olamaz');
  Map<String, String>? locationInfo = await getUserLocationInfo(context);
  if (locationInfo != null) {
    String country = locationInfo['country'] ?? 'Bilinmiyor';
    String city = locationInfo['city'] ?? 'Bilinmiyor';

    FirebaseServiceAddProduct().addProduct(
        productName: productname,
        status: state,
        imageList: image,
        productDescription: productdes,
        mainCategory: maincategory,
        subCategory: subcategory,
        price: double.parse(productMoney),
        country: country,
        city: city,
        useruid: FirebaseAuth.instance.currentUser!.uid);
  } else {
    FirebaseServiceAddProduct().addProduct(
        productName: productname,
        status: state,
        imageList: image,
        productDescription: productdes,
        mainCategory: maincategory,
        subCategory: subcategory,
        price: double.parse(productMoney),
        country: "United States",
        city: "Mountain View",
        useruid: FirebaseAuth.instance.currentUser!.uid);
  }
}
