import 'package:flutter/cupertino.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/services/auth_service.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/imageclass.dart';
import 'package:otoku/utils/showsnackbar.dart';
import 'package:otoku/widgets/custombutton.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textfield.dart';
import 'package:otoku/widgets/textmodels.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageModel(
      body: _buildRegistrationForm(context),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            AssetImages.images['register']!,
            height: 340,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Sign up',
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 50,
                  fontFamily: 'BlackOpsOne',
                  fontWeight: FontWeight.w500,
                ),
              ),
              sizedBoxH(20),
              customTextField(
                controller: _nameController,
                icon: CupertinoIcons.person,
                labelText: "Name",
              ),
              sizedBoxH(10),
              customTextField(
                controller: _emailController,
                icon: CupertinoIcons.mail,
                labelText: "Email",
              ),
              sizedBoxH(10),
              Row(
                children: [
                  Expanded(
                    child: customTextField(
                      controller: _passController,
                      labelText: "Password",
                      isPassword: true,
                    ),
                  ),
                  sizedBoxW(10),
                  Expanded(
                    child: customTextField(
                      controller: _repassController,
                      labelText: "Re-Password",
                      isPassword: true,
                    ),
                  ),
                ],
              ),
              sizedBoxH(10),
              customButton(
                width: 2,
                context: context,
                text: 'Create account',
                onPressed: () async {
                  if (_emailController.text.isNotEmpty &&
                      _passController.text.isNotEmpty) {
                    if (_passController.text == _repassController.text) {
                      String? registercontrol = await AuthService()
                          .registerWithEmailAndPassword(_emailController.text,
                              _passController.text, _nameController.text);
                      if (registercontrol == null) {
                        widget.controller.animateToPage(2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      } else {
                        showSnackBar(
                            context, AppColors.errorcolors, registercontrol);
                      }
                    } else {
                      showSnackBar(context, AppColors.errorcolors,
                          "Şİfreler Aynı Değil");
                    }
                  } else {
                    showSnackBar(context, AppColors.errorcolors,
                        "Lütfen Tüm Alanları Doldurunuz");
                  }
                },
              ),
              sizedBoxH(15),
              Row(
                children: [
                  CustomText(
                    text: 'Have an account?',
                    style: TextStyle(
                      color: Color(0xFF837E93),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  sizedBoxW(2.5),
                  CustomText(
                    text: 'Log In ',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    ontap: () {
                      widget.controller.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
