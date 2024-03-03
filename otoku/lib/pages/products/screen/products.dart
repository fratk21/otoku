import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/home/viewmodel/productmodel.dart';
import 'package:otoku/services/location.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/widgets/indicator.dart';

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
                FutureBuilder<Map<String, String>?>(
                  future: getUserLocationInfo(context),
                  builder: (context, locationSnapshot) {
                    if (locationSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      // Kullanıcı konum bilgisi yükleniyorsa bir yükleniyor göstergesi göster
                      return CustomProgressIndicator();
                    } else if (locationSnapshot.hasError) {
                      // Hata oluştuysa hata mesajını göster
                      return Text('Error: ${locationSnapshot.error}');
                    } else {
                      // Kullanıcı konum bilgisi başarıyla alındıysa
                      Map<String, String>? locationInfo = locationSnapshot.data;
                      String userCountry =
                          locationInfo?['country'] ?? 'Bilinmiyor';

                      return FutureBuilder(
                        // Firestore'dan sadece kullanıcının ülkesine ait verileri alın
                        future: FirebaseFirestore.instance
                            .collection('products')
                            .where('country', isEqualTo: userCountry)
                            .where("mainCategory",
                                isEqualTo: widget.category['category_name'])
                            .where("subCategory", isEqualTo: widget.subcategory)
                            .get(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Veri henüz yüklenmediyse bir yükleniyor göstergesi göster
                            return CustomProgressIndicator();
                          } else if (snapshot.hasError) {
                            // Hata oluştuysa hata mesajını göster
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // Veriler başarıyla alındıysa, GridView'i oluştur
                            List<DocumentSnapshot> products =
                                snapshot.data!.docs;

                            return GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: List.generate(products.length, (index) {
                                // Her bir ürünü göstermek için bir widget döndürün
                                return productmodel(
                                  snap: snapshot.data!.docs[index].data(),
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
          ),
        ),
      ),
    );
  }
}
