import 'package:flutter/material.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textmodels.dart';

Widget customCard({
  required String title,
  required String description,
  required String image,
}) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 0,
    color: AppColors.transparent,
    child: Row(
      children: [
        Image.asset(
          image,
          height: 100,
          width: 100,
        ),
        sizedBoxW(10),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Metinleri sola hizalayın
          children: [
            CustomText(
                text: title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2),
            sizedBoxH(5),
            Container(
                width: 200,
                child: CustomText(
                    text: description,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    maxLines: 6)),
          ],
        ),
      ],
    ),
  );
}

Widget createCardList(List<Map<String, String>> cardDataList) {
  List<Widget> cardWidgets = [];

  for (var cardData in cardDataList) {
    cardWidgets.add(
      customCard(
        title: cardData['title'] ?? '',
        description: cardData['description'] ?? '',
        image: cardData['image'] ?? '',
      ),
    );
  }

  return Column(
    children: cardWidgets,
  );
}
