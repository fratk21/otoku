import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/widgets/custombutton.dart';
import 'package:otoku/widgets/customdropdown.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textfield.dart';
import 'package:otoku/widgets/textmodels.dart';

class add_product_screen extends StatefulWidget {
  final Map<String, dynamic> category;

  final String subcategory;
  const add_product_screen({
    super.key,
    required this.category,
    required this.subcategory,
  });

  @override
  State<add_product_screen> createState() => _add_product_screenState();
}

class _add_product_screenState extends State<add_product_screen> {
  List<Uint8List?> containerImages = List.generate(8, (_) => null);
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
    print(widget.category['category_name']);
    print(widget.subcategory);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        "${widget.category['category_name']} --> ${widget.subcategory}"),
                  ],
                ),
                sizedBoxH(10),
                buildGridOfDottedContainersWithFunction(2, 3, (index) {
                  pickImage(index);
                }),
                sizedBoxH(10),
                customTextField(
                    labelText: 'Product Name',
                    icon: Icons.apps,
                    onIconTap: () {},
                    maxLength: 50),
                sizedBoxH(10),
                customTextField(
                    labelText: 'Product Description',
                    icon: Icons.description,
                    onIconTap: () {},
                    maxLines: 5),
                sizedBoxH(10),
                CustomText(
                  text: "Durum",
                  alignment: MainAxisAlignment.start,
                ),
                SizedBox(
                  height: 70,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(16.0),
                    children: [
                      buildRadioButton('Yeni'),
                      buildRadioButton('Yeni Gibi'),
                      buildRadioButton('İyi'),
                      buildRadioButton('Makul'),
                      buildRadioButton('Yıpranmış'),
                    ],
                  ),
                ),
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
      ),
    );
  }

  Widget buildRadioButton(String option) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selectedOption == option ? AppColors.orange : AppColors.white,
          side: BorderSide(
            color: selectedOption == option
                ? AppColors.orange
                : AppColors.flashwhite,
          ),
        ),
        onPressed: () {
          setState(() {
            selectedOption = option;
          });
        },
        child: Text(
          option,
          style: TextStyle(
              color:
                  selectedOption == option ? AppColors.white : AppColors.gblue),
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
