import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/home/screen/product.details.dart';
import 'package:otoku/services/firestore_methods.dart';
import 'package:otoku/utils/colors.dart';

class productmodel extends StatefulWidget {
  final snap;
  const productmodel({super.key, required this.snap});

  @override
  State<productmodel> createState() => _productmodelState();
}

class _productmodelState extends State<productmodel> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => productdetailscreen(snap: widget.snap),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Radiuslu olacak
              border: Border.all(
                  color: AppColors.gblue, width: 1.3), // İnce ve siyah border
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.snap["imageUrlList"][0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.snap["price"].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.snap["productName"].toString(),
                    overflow: TextOverflow
                        .ellipsis, // Metin kesildiğinde "..." ile göster
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "${widget.snap["country"].toString()} , ${widget.snap["city"].toString()}",
                    overflow: TextOverflow
                        .ellipsis, // Metin kesildiğinde "..." ile göster
                    maxLines: 1, // Metin sadece bir satırda gösterilsin
                    style: TextStyle(color: AppColors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 0, // Yatayda üst kenara yapışık
            right: 0, // Dikeyde sağ kenara yapışık
            child: Center(
              child: IconButton(
                iconSize: 30,
                icon: widget.snap['likes']
                        .contains(FirebaseAuth.instance.currentUser!.uid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                      ),
                onPressed: () => FireStoreMethods().likePost(
                  widget.snap['productid'].toString(),
                  FirebaseAuth.instance.currentUser!.uid,
                  widget.snap['likes'],
                ),
              ),
            )),
      ],
    );
  }
}
