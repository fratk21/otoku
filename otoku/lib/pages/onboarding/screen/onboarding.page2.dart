import 'package:flutter/material.dart';
import 'package:otoku/navigator.dart';
import 'package:otoku/pages/onboarding/viewmodel/onboarding.viewmodel.dart';
import 'package:otoku/services/location.dart';
import 'package:otoku/utils/colors.dart';

class page2 extends StatefulWidget {
  const page2({super.key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: flashwhite,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    "Başlamadan Önce",
                    style: TextStyle(
                        fontFamily: "BlackOpsOne", fontSize: 35, color: orange),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      stun(
                          title: "Yakındaki Satıcılar",
                          description:
                              "Konum izni, size yakın olan diğer satıcıları  bulmanıza yardımcı olur.",
                          image: "assets/image/konum.png"),
                      stun(
                          title: "Teslimat İşlemleri",
                          description:
                              "Konum bilgisi, ürünün nerede teslim edileceğini veya alınacağını belirlemek için önemlidir.",
                          image: "assets/image/kargo.png"),
                      stun(
                          title: "Güvenlik ",
                          description:
                              "Konum bilgisi, işlem yapmadan önce karşı tarafın gerçek ve güvenilir olduğundan emin olmanıza yardımcı olabilir.",
                          image: "assets/image/guven.png"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    // Butona tıklandığında yapılacak işlem
                    final locationInfo;
                    if (hasPermission) {
                      locationInfo = await getUserLocationInfo(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => navigatorscreen(),
                          ));
                    } else {
                      locationInfo = await getUserLocationInfo(context);
                      if (locationInfo != null) {
                        final country = locationInfo["country"];
                        final city = locationInfo["city"];

                        print("Kullanıcının Ülkesi: $country");
                        print("Kullanıcının Şehri: $city");
                      } else {
                        print("Konum bilgisi alınamadı veya izin verilmedi.");
                      }

                      hasPermission = await checkLocationPermission();

                      setState(() {
                        hasPermission;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: gblue, // Düğme rengi mavi
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Radius
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // İkon ile metin arasına boşluk ekleyin
                      Text(
                        hasPermission
                            ? "Devam Et"
                            : "Konum izni vermek için tıklayınız",
                        style: TextStyle(
                          color: Colors.white, // Yazı rengi beyaz
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.location_history,
                        color: Colors.white, // İkon rengi beyaz
                      ),
                    ],
                  ),
                ),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
