import 'package:flutter/material.dart';

Widget customButton(
    {double width = 0.8, // Genişlik yüzde olarak ayarlandı
    double height = 0.08, // Yükseklik yüzde olarak ayarlandı
    Color backgroundColor = Colors.orange,
    String text = 'Go Go',
    VoidCallback? onPressed,
    IconData? iconData,
    required BuildContext context}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    child: SizedBox(
      width: screenWidth * width, // Genişliği yüzde olarak hesapla
      height: screenHeight * height, // Yüksekliği yüzde olarak hesapla
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                size: 20,
                color: Colors.white,
              ),
            SizedBox(
                width: iconData != null
                    ? screenWidth * 0.02
                    : 0), // Ikon varsa boşluk yüzde olarak hesapla
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
