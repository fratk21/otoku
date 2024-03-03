import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/showsnackbar.dart';

class kullaniciad_screen extends StatefulWidget {
  const kullaniciad_screen({super.key});

  @override
  State<kullaniciad_screen> createState() => _kullaniciad_screenState();
}

class _kullaniciad_screenState extends State<kullaniciad_screen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool edit = false;
  TextEditingController ad = TextEditingController();

  getdata() async {
    var meSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    try {
      ad.text = meSnap.data()!['username'];
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            "Kullanıcı Adım",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  edit = true;
                  setState(() {
                    edit;
                  });
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: const Text(
                  "*Bu bilgileri herkes görebilecektir",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              textfield(
                  ad, "Kullanıcı Adınız", Icons.account_circle_outlined, edit),
              const SizedBox(
                height: 10,
              ),
              edit == false
                  ? Container()
                  : SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _firestore
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "username": ad.text,
                          });
                          showSnackBar(context, AppColors.gblue, "Kaydedildi");
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueAccent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
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
