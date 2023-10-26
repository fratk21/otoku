import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/pages/forgotpasssword/view/forgotpass.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/imageclass.dart';
import 'package:otoku/widgets/custombutton.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textfield.dart';
import 'package:otoku/widgets/textmodels.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageModel(
      body: _buildLoginForm(context),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AssetImages.images['login']!,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Log In",
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 50,
                  fontFamily: 'BlackOpsOne',
                  fontWeight: FontWeight.w500,
                ),
              ),
              sizedBoxH(20),
              customTextField(
                controller: _emailController,
                labelText: "email",
                icon: CupertinoIcons.mail,
              ),
              sizedBoxH(10),
              customTextField(
                controller: _passController,
                labelText: "Password",
                isPassword: true,
                icon: CupertinoIcons.lock,
              ),
              sizedBoxH(20),
              customButton(
                width: 2,
                context: context,
                text: 'Sign In',
                onPressed: () {},
              ),
              sizedBoxH(15),
              Row(
                children: [
                  CustomText(
                    text: 'Don’t have an account?',
                    style: TextStyle(
                      color: Color(0xFF837E93),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  sizedBoxW(2.5),
                  CustomText(
                    text: 'Sign Up',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    ontap: () {
                      widget.controller.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                  )
                ],
              ),
              sizedBoxH(15),
              CustomText(
                text: 'Forget Password?',
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotpassScreen(),
                      ));
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
