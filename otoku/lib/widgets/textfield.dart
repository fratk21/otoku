import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otoku/utils/colors.dart';

Widget customTextField({
  TextEditingController? controller,
  String? labelText,
  IconData? icon,
  void Function()? onIconTap,
  int maxLines = 1,
  int? maxlength,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxlength),
      ],
      controller: controller,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: gblue,
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      maxLines: maxLines, // Satır sayısını ayarlayın
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: gblue,
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: gblue,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: gblue,
          ),
        ),
        prefixIcon: icon != null
            ? IconButton(
                onPressed: onIconTap,
                icon: Icon(icon, color: gblue),
              )
            : null,
      ),
    ),
  );
}


// Kullanım örneği:
// customTextField(controller: _passController, labelText: 'Password', icon: Icons.lock, onIconTap: () { /* Icon tıklandığında yapılacak işlem */ })
