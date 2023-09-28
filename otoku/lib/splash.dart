import 'package:flutter/material.dart';
import 'package:otoku/utils/colors.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Text(
                  "OTOKU",
                  style: TextStyle(
                      fontFamily: "BlackOpsOne", fontSize: 80, color: orange),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Projeckt",
                      style: TextStyle(
                          fontFamily: "BlackOpsOne",
                          fontSize: 30,
                          color: white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Error",
                      style: TextStyle(
                          fontFamily: "BlackOpsOne",
                          fontSize: 30,
                          color: errorcolors),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
