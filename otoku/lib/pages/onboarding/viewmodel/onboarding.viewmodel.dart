import 'package:flutter/material.dart';

class stun extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const stun(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      color: Colors.transparent,
      child: Row(
        children: [
          Image.asset(
            image,
            height: 100,
            width: 100,
          ),

          SizedBox(width: 10), // İkon ile metin arasına boşluk ekleyin
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Metinleri sola hizalayın
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5), // Metinler arasına boşluk ekleyin
              Container(
                width: 200, // Metin kutusu genişliğini ayarlayın
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
