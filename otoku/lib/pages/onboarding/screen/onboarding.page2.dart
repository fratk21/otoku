import 'package:flutter/material.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/navigator.dart';
import 'package:otoku/pages/onboarding/viewmodel/onboarding.viewmodel.dart';
import 'package:otoku/services/location.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/custombutton.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textmodels.dart';

class onboardingpage2 extends StatefulWidget {
  const onboardingpage2({super.key});

  @override
  State<onboardingpage2> createState() => _onboardingpage2State();
}

class _onboardingpage2State extends State<onboardingpage2> {
  bool hasPermission = false;
  void control() async {
    hasPermission = await checkLocationPermission();
    setState(() {
      hasPermission;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control();
  }

  List<Map<String, String>> cardDataList = [
    {
      "title": "Yakındaki Satıcılar",
      "description":
          "Konum izni, size yakın olan diğer satıcıları  bulmanıza yardımcı olur.",
      "image": "assets/image/konum.png"
    },
    {
      "title": "Teslimat İşlemleri",
      "description":
          "Konum bilgisi, ürünün nerede teslim edileceğini veya alınacağını belirlemek için önemlidir.",
      "image": "assets/image/kargo.png"
    },
    {
      "title": "Güvenlik ",
      "description":
          "Konum bilgisi, işlem yapmadan önce karşı tarafın gerçek ve güvenilir olduğundan emin olmanıza yardımcı olabilir.",
      "image": "assets/image/guven.png"
    }
    // Diğer kartlar
  ];

  Future<void> handleLocationPermissionAndNavigate(BuildContext context) async {
    var hasPermission = await checkLocationPermission();
    final locationInfo = await getUserLocationInfo(context);

    if (hasPermission) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => navigatorscreen(),
        ),
      );
    } else {
      if (locationInfo != null) {
        final country = locationInfo["country"];
        final city = locationInfo["city"];

        print("Kullanıcının Ülkesi: $country");
        print("Kullanıcının Şehri: $city");
      } else {
        print("Konum bilgisi alınamadı veya izin verilmedi.");
      }

      final updatedPermission = await checkLocationPermission();

      setState(() {
        hasPermission = updatedPermission;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageModel(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          sizedBoxH(20),
          Column(
            children: [
              CustomText(
                text: "Başlamadan Önce",
                style: TextStyle(
                    fontFamily: "BlackOpsOne",
                    fontSize: 35,
                    color: AppColors.orange),
              ),
              sizedBoxH(40),
              createCardList(cardDataList)
            ],
          ),
          sizedBoxH(30),
          customButton(
              context: context,
              text: hasPermission
                  ? "Devam Et"
                  : "Konum izni vermek için tıklayınız",
              iconData: Icons.location_history,
              height: 0.06,
              onPressed: () async {
                handleLocationPermissionAndNavigate(context);
              },
              backgroundColor: AppColors.gblue),
          sizedBoxH(15),
        ],
      ),
    );
  }
}
