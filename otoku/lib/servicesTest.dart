import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future<void> addProduct({
    required String productName,
    required String status,
    required List<String> imageUrlList,
    required String productDescription,
    required String mainCategory,
    required String subCategory,
    required double price,
  }) async {
    try {
      await productsCollection.add({
        'productName': productName,
        'status': status,
        'imageUrlList': imageUrlList,
        'productDescription': productDescription,
        'mainCategory': mainCategory,
        'subCategory': subCategory,
        'creationDate': Timestamp.now(),
        'price': price,
      });
      print('Ürün başarıyla kaydedildi.');
    } catch (e) {
      print('Ürün kaydedilirken hata oluştu: $e');
    }
  }
}

class FirebaseServices {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  // Filtreleme ve sıralama metodu
  Future<List<DocumentSnapshot>> getFilteredProducts({
    String? sortBy,
    String? sortOrder,
    String? statusFilter,
    String? categoryFilter,
    double? minPrice,
    double? maxPrice,
  }) async {
    Query query = productsCollection;

    // Duruma göre filtreleme
    if (statusFilter != null && statusFilter.isNotEmpty) {
      query = query.where('status', isEqualTo: statusFilter);
    }

    // Kategoriye göre filtreleme
    if (categoryFilter != null && categoryFilter.isNotEmpty) {
      query = query.where('mainCategory', isEqualTo: categoryFilter);
    }

    // Fiyata göre filtreleme
    if (minPrice != null) {
      query = query.where('price', isGreaterThanOrEqualTo: minPrice);
    }

    if (maxPrice != null) {
      query = query.where('price', isLessThanOrEqualTo: maxPrice);
    }

    // Sıralama
    if (sortBy != null && sortBy.isNotEmpty) {
      query = query.orderBy(sortBy, descending: sortOrder == 'desc');
    }

    // Firestore sorgusunu çalıştır
    QuerySnapshot querySnapshot = await query.get();

    return querySnapshot.docs;
  }
}

// kullanım

//class ProductListPage extends StatelessWidget {
//  final FirebaseService firebaseService = FirebaseService();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(//
  //      title: Text('Ürün Listesi'),
  //    ),
//      body: FutureBuilder<List<DocumentSnapshot>>(
//        future: firebaseService.getFilteredProducts(
//          sortBy: 'creationDate', // Sıralama kriteri
//          sortOrder: 'desc', // Sıralama sırası
//          statusFilter: 'active', // Durum filtresi
//          categoryFilter: 'manga', // Kategori filtresi
//          minPrice: 50.0, // Minimum fiyat filtresi
//          maxPrice: 200.0, // Maksimum fiyat filtresi
 //       ),
//        builder: (context, snapshot) {
//          if (snapshot.connectionState == ConnectionState.waiting) {
  //          return CircularProgressIndicator();
//          } else if (snapshot.hasError) {
   //         return Text('Hata: ${snapshot.error}');
//          } else {
            // Ürünleri göstermek için gerekli widget'ı kullanabilirsiniz
  //          List<DocumentSnapshot> products = snapshot.data!;
 //           return ListView.builder(
    //          itemCount: products.length,
      //        itemBuilder: (context, index) {
        //        return ListTile(
          //        title: Text(products[index]['productName']),
            //    );
             // },
            //);
//          }
//        },
//      ),
//    );
//  }
//}
