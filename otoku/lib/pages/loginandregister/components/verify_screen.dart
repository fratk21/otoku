import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:otoku/navigator.dart';
import 'package:otoku/pages/loginandregister/viewmodel/otp_form.dart';
import 'package:otoku/pages/onboarding/screen/onboarding.screen.dart';
import 'package:otoku/services/user_service.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:otoku/utils/showsnackbar.dart';
import 'package:otoku/widgets/custombutton.dart';
import 'package:otoku/widgets/indicator.dart';
import 'package:otoku/widgets/sizedbox.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool varifytime = false;
  bool isEmailVerified = false;
  Timer? timer;
  UserService auth = UserService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      // TODO: implement your code after email verification
      showSnackBar(context, AppColors.orange, "Email Onaylandı");

      timer?.cancel();
      Future.delayed(Duration(milliseconds: 100));
      PageNavigator.push(context, navigatorscreen());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Image.asset(
                  "assets/image/verify.png",
                  // height: 400,
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Onaylama kodu ${auth.getCurrentUser()!.email} \nadresine gönderildi',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomProgressIndicator(),
                  sizedBoxH(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Resend  ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TimerCountdown(
                        spacerWidth: 0,
                        enableDescriptions: false,
                        colonsTextStyle: TextStyle(
                          color: AppColors.orange,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        timeTextStyle: TextStyle(
                          color: AppColors.orange,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        format: CountDownTimerFormat.minutesSeconds,
                        endTime: DateTime.now().add(
                          const Duration(
                            minutes: 3,
                            seconds: 0,
                          ),
                        ),
                        onEnd: () {
                          setState(() {
                            varifytime = true;
                          });
                        },
                      ),
                    ],
                  ),
                  sizedBoxH(10),
                  customButton(
                    context: context,
                    text: "Tekrar Gönder",
                    height: 0.06,
                    onPressed: () {
                      if (varifytime) {
                        FirebaseAuth.instance.currentUser
                            ?.sendEmailVerification();
                        timer = Timer.periodic(const Duration(seconds: 3),
                            (_) => checkEmailVerified());
                      } else {
                        showSnackBar(context, AppColors.errorcolors,
                            "Lütfen sürenin bitmesini bekleyiniz");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
