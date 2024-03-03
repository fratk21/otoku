import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otoku/services/addforum.services.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:otoku/widgets/custombutton.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textfield.dart';

class addForum extends StatefulWidget {
  const addForum({super.key});

  @override
  State<addForum> createState() => _addForumState();
}

class _addForumState extends State<addForum> {
  TextEditingController topic = TextEditingController();
  TextEditingController des = TextEditingController();

  String selectedValue = 'New';
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              sizedBoxH(10),
              customTextField(
                  controller: topic,
                  labelText: 'Forum Konusu',
                  icon: Icons.apps,
                  onIconTap: () {},
                  maxLength: 50),
              sizedBoxH(10),
              customTextField(
                  controller: des,
                  labelText: 'İçerik',
                  icon: Icons.description,
                  onIconTap: () {},
                  maxLines: 10),
              sizedBoxH(10),
              customButton(
                context: context,
                text: "Ekle",
                onPressed: () async {
                  addForumEntry(topic.text, des.text,
                      FirebaseAuth.instance.currentUser!.uid);
                  PageNavigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
