import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otoku/services/auth_service.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/showsnackbar.dart';

class sifredegis_screen extends StatefulWidget {
  const sifredegis_screen({super.key});

  @override
  State<sifredegis_screen> createState() => _sifredegis_screenState();
}

class _sifredegis_screenState extends State<sifredegis_screen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool edit = true;
  TextEditingController esifre = TextEditingController();
  TextEditingController nsifre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            "Şifrem",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              textfield(esifre, "Eski Şifreniz", Icons.lock_open_sharp, edit),
              textfield(
                  nsifre, "Yeni Şifreniz", Icons.lock_outline_rounded, edit),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    AuthService().changePassword(esifre.text, nsifre.text);
                    showSnackBar(context, AppColors.gblue, "Kaydedildi");
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      )),
                  child: const Text("Kaydet"),
                ),
              ),
            ],
          ),
        ));
  }
}

Padding textfield(TextEditingController controller, String hinttext,
    IconData icon, bool edit) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: SizedBox(
      height: 60,
      child: Material(
        //elevation: 8,
        // shadowColor: Colors.black87,
        // color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          enabled: edit,
          controller: controller,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            hintText: hinttext,
            prefixIcon: Icon(icon),
          ),
        ),
      ),
    ),
  );
}
