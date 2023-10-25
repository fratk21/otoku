import 'package:flutter/material.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textmodels.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return PageModel(body: buildCustombody());
  }
}

Widget buildCustombody() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: "OTOKU",
          style: TextStyle(
            fontFamily: "BlackOpsOne",
            fontSize: 80,
            color: AppColors.orange,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Projeckt",
              style: TextStyle(
                fontFamily: "BlackOpsOne",
                fontSize: 30,
                color: AppColors.white,
              ),
            ),
            sizedBoxW(5),
            CustomText(
              text: "Error",
              style: TextStyle(
                fontFamily: "BlackOpsOne",
                fontSize: 30,
                color: AppColors.errorcolors,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
