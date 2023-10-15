import 'package:flutter/material.dart';
import 'package:otoku/pages/onboarding/viewmodel/onboarding.viewmodel.dart';
import 'package:otoku/utils/colors.dart';

class page1 extends StatelessWidget {
  const page1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: flashwhite,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Welcome To Otoku",
                  style: TextStyle(
                      fontFamily: "BlackOpsOne", fontSize: 35, color: orange),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  stun(
                      title: "Figür ve Manga Dünyası",
                      description:
                          "Otoku, en sevdiğiniz Figür ve Manga ürünlerini keşfetmeniz için burada!",
                      image: "assets/image/manga.png"),
                  stun(
                      title: "2. El Satış ve Alış",
                      description:
                          "İhtiyacınız olan Figür ve Manga ürünlerini satabilir veya alabilirsiniz.",
                      image: "assets/image/shop.png"),
                  stun(
                      title: "Cosplay Meraklıları",
                      description:
                          "Cosplay meraklıları için en son kostüm ve aksesuarları bulun.",
                      image: "assets/image/dress.png"),
                  stun(
                      title: "Otoku forumu",
                      description:
                          "Anime, Manga ve Cosplay hakkında konuşmak için foruma katılın ve yeni arkadaşlar edinin.",
                      image: "assets/image/forum.png"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
