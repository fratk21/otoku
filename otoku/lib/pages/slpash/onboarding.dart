import 'package:flutter/material.dart';
import 'package:otoku/navigator.dart';
import 'package:otoku/services/location.dart';
import 'package:otoku/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  PageController _controller = PageController();
  bool onlastpage = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onlastpage = (index == 1);
              });
            },
            children: [
              page1(),
              page2(),
            ],
          ),
          Container(
              alignment: Alignment(0, 0.95),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 2,
                    effect: SlideEffect(
                        spacing: 8.0,
                        radius: 5,
                        dotWidth: 60.0,
                        dotHeight: 13.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1,
                        dotColor: gblue,
                        activeDotColor: rose),
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: flashwhite,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Başlamadan Önce",
                    style: TextStyle(
                        fontFamily: "BlackOpsOne", fontSize: 35, color: orange),
                  ),
                  SizedBox(
                    height: 30,
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
