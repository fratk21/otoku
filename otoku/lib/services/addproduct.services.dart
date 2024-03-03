import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServiceAddProduct {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addProduct({
    required String productName,
    required String status,
    required List<Uint8List?> imageList,
    required String productDescription,
    required String mainCategory,
    required String subCategory,
    required double price,
    required String country,
    required String city,
    required String useruid,
  }) async {
    try {
      List<String> imageUrlList = [];

      for (Uint8List? image in imageList) {
        if (image != null) {
          String imageUrl = await uploadImageToStorage(image);
          imageUrlList.add(imageUrl);
        }
      }
      String productid = Uuid().v1();
      DateTime now = DateTime.now();
      String formattedDate = "${now.day}-${now.month}-${now.year}";
      await productsCollection.doc(productid).set({
        'productName': productName,
        'status': status,
        'imageUrlList': imageUrlList,
        'productDescription': productDescription,
        'mainCategory': mainCategory,
        'subCategory': subCategory,
        'creationDate': formattedDate,
        'price': price,
        'country': country,
        'city': city,
        'useruid': useruid,
        "likes": [],
        "productid": productid
      });

      print('Ürün başarıyla kaydedildi.');
    } catch (e) {
      print('Ürün kaydedilirken hata oluştu: $e');
    }
  }

  Future<String> uploadImageToStorage(Uint8List file) async {
    Reference ref = _storage.ref().child('product_images').child(Uuid().v1());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
