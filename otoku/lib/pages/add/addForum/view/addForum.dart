import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/custombutton.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textfield.dart';

class addForum extends StatefulWidget {
  const addForum({super.key});

  @override
  State<addForum> createState() => _addForumState();
}

class _addForumState extends State<addForum> {
  List<Uint8List?> containerImages = List.generate(3, (_) => null);
  String selectedValue = 'New';
  String selectedOption = '';
  Future<void> pickImage(int index) async {
    final imagePicker = ImagePicker();
    final im = await pickImageFromSource(imagePicker, ImageSource.gallery);
    if (im != null) {
      setState(() {
        containerImages[index] = im;
      });
    }
  }

  Future<Uint8List?> pickImageFromSource(
      ImagePicker imagePicker, ImageSource source) async {
    final XFile? file = await imagePicker.pickImage(source: source);
    try {
      if (file != null) {
        return await file.readAsBytes();
      } else {
        print('No Image Selected');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildGridOfDottedContainersWithFunction(1, 3, (index) {
                pickImage(index);
              }),
              sizedBoxH(10),
              customTextField(
                  labelText: 'Forum Konusu',
                  icon: Icons.apps,
                  onIconTap: () {},
                  maxLength: 50),
              sizedBoxH(10),
              customTextField(
                  labelText: 'İçerik',
                  icon: Icons.description,
                  onIconTap: () {},
                  maxLines: 10),
              sizedBoxH(10),
              customButton(
                context: context,
                text: "Ekle",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridOfDottedContainersWithFunction(
      int rows, int columns, Function(int) onTap) {
    return Column(
      children: List.generate(rows, (i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(columns, (j) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: GestureDetector(
                onTap: () {
                  onTap(i * columns + j);
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(15),
                  padding: EdgeInsets.all(4),
                  color: AppColors.gblue,
                  strokeWidth: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    width: 100,
                    height: 100,
                    child: containerImages[i * columns + j] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Image.memory(
                              containerImages[i * columns + j]!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Icon(
                              Icons.add,
                              size: 24,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
