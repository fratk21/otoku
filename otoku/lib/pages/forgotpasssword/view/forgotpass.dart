import 'package:flutter/material.dart';
import 'package:otoku/services/auth_service.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/showsnackbar.dart';
import 'package:otoku/widgets/custombutton.dart';

class ForgotpassScreen extends StatefulWidget {
  const ForgotpassScreen({
    super.key,
  });

  @override
  State<ForgotpassScreen> createState() => _ForgotpassScreenState();
}

class _ForgotpassScreenState extends State<ForgotpassScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Center(
                child: Image.asset(
                  "assets/image/forgot.png",
                  height: 300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 50,
                      fontFamily: 'BlackOpsOne',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.gblue,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: AppColors.gblue,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.gblue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.gblue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  customButton(
                    context: context,
                    text: 'Şifre sıfırlama Linki gönder',
                    onPressed: () async {
                      String? resetpasscontrol = await AuthService()
                          .resetPassword(_emailController.text);
                      if (resetpasscontrol == null) {
                        showSnackBar(context, AppColors.orange,
                            "Emailinizi kontrol ediniz");
                      } else {
                        showSnackBar(
                            context, AppColors.errorcolors, resetpasscontrol);
                      }
                      print("object");
                    },
                  ),
                  const SizedBox(
                    height: 15,
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
