import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/widgets/customdropdown.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/widgets/textfield.dart';

class add_product_screen extends StatefulWidget {
  const add_product_screen({super.key});

  @override
  State<add_product_screen> createState() => _add_product_screenState();
}

class _add_product_screenState extends State<add_product_screen> {
  List<Uint8List?> containerImages = List.generate(8, (_) => null);
  String selectedValue = 'New';

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
    return PageModel(
      appBar: CustomAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            buildGridOfDottedContainersWithFunction(2, 3, (index) {
              pickImage(index);
            }),
            customTextField(
                labelText: 'Product Name',
                icon: Icons.apps,
                onIconTap: () {},
                maxLength: 50),
            customTextField(
                labelText: 'Product Description',
                icon: Icons.description,
                onIconTap: () {},
                maxLines: 5),
            AnimatedDropdown(
              dropdownItems: ['Seçiniz', 'Öğe 1', 'Öğe 2', 'Öğe 3'],
              onChanged: (String selectedValue) {
                print('Seçilen öğe: $selectedValue');
              },
              label: "Durum",
            ),
          ],
        ),
      )),
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
