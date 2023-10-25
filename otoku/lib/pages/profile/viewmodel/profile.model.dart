import 'package:flutter/material.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textmodels.dart';

Widget createStatCard({String value = "", String label = ""}) {
  return Column(
    children: [
      CustomText(
        text: value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      sizedBoxH(15),
      CustomText(
        text: label,
        style: TextStyle(
          color: AppColors.black.withOpacity(0.3),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      )
    ],
  );
}

Widget createUserProfileCard(String image, String username) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: 70.0,
      ),
      sizedBoxH(20),
      CustomText(
        text: username,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 25.0,
        ),
        // alignment: MainAxisAlignment.center,
      )
    ],
  );
}

Widget createStatRow(List<String> values) {
  final labels = ["İlanlar", "Yazılar", "Rozetler"];

  if (values.length != labels.length) {
    throw Exception("Values and labels should have the same length");
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(values.length, (index) {
      return createStatCard(value: values[index], label: labels[index]);
    }),
  );
}
