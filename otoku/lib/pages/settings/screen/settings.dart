import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/loginandregister/view/main_view.dart';
import 'package:otoku/pages/settings/screen/kullaniciad.dart';
import 'package:otoku/pages/settings/screen/sifredegis.dart';
import 'package:otoku/services/auth_service.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:otoku/widgets/appbarmodel.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: false,
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.white,
          title: Text(
            "OTOKU SETTINGS",
            style: TextStyle(
              fontFamily: "BlackOpsOne",
              fontSize: 30,
              color: AppColors.orange,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // User card
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      PageNavigator.push(context, sifredegis_screen());
                    },
                    icons: CupertinoIcons.padlock,
                    iconStyle: IconStyle(),
                    title: 'Şifre işlemleri',
                    subtitle: "Şifremi değiştir",
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      PageNavigator.push(context, kullaniciad_screen());
                    },
                    icons: CupertinoIcons.number_square,
                    iconStyle: IconStyle(),
                    title: 'Username işlemleri',
                    subtitle: "Username değiştir",
                  ),
                ],
              ),

              // You can add a settings title
              SettingsGroup(
                settingsGroupTitle: "Account",
                items: [
                  SettingsItem(
                    onTap: () async {
                      await AuthService().signOut();
                      PageNavigator.push(context, MainView());
                    },
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
