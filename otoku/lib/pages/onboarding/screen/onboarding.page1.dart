import 'package:flutter/material.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/pages/onboarding/viewmodel/onboarding.viewmodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textmodels.dart';

class onboardingpage1 extends StatefulWidget {
  const onboardingpage1({super.key});

  @override
  State<onboardingpage1> createState() => _onboardingpage1State();
}

class _onboardingpage1State extends State<onboardingpage1> {
  List<Map<String, String>> cardDataList = [
    {
      "title": "Figür ve Manga Dünyası",
      "description":
          "Otoku, en sevdiğiniz Figür ve Manga ürünlerini keşfetmeniz için burada!",
      "image": "assets/image/manga.png"
    },
    {
      "title": "2. El Satış ve Alış",
      "description":
          "İhtiyacınız olan Figür ve Manga ürünlerini satabilir veya alabilirsiniz.",
      "image": "assets/image/shop.png"
    },
    {
      "title": "Cosplay Meraklıları",
      "description":
          "Cosplay meraklıları için en son kostüm ve aksesuarları bulun.",
      "image": "assets/image/dress.png"
    },
    {
      "title": "Otoku forumu",
      "description":
          "Anime, Manga ve Cosplay hakkında konuşmak için foruma katılın ve yeni arkadaşlar edinin.",
      "image": "assets/image/forum.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return PageModel(
      body: Column(
        children: [
          sizedBoxH(50),
          CustomText(
            text: "Welcome To Otoku",
            style: TextStyle(
                fontFamily: "BlackOpsOne",
                fontSize: 35,
                color: AppColors.orange),
          ),
          sizedBoxH(30),
          createCardList(cardDataList)
        ],
      ),
    );
  }
}
