import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otoku/utils/colors.dart';

class customTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final IconData? icon;
  final void Function()? onIconTap;
  final bool isPassword;
  final int maxLines;
  final int? maxLength;

  customTextField({
    this.controller,
    this.labelText,
    this.icon,
    this.onIconTap,
    this.isPassword = false,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  _customTextFieldState createState() => _customTextFieldState();
}

class _customTextFieldState extends State<customTextField> {
  late bool isPassword;

  @override
  void initState() {
    super.initState();
    isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxLength),
      ],
      controller: widget.controller,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: AppColors.gblue,
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      maxLines: widget.maxLines,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: AppColors.gblue,
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.gblue,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.gblue,
          ),
        ),
        prefixIcon: widget.icon != null
            ? IconButton(
                onPressed: widget.onIconTap,
                icon: Icon(widget.icon, color: AppColors.gblue),
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPassword = !isPassword;
                  });
                },
                icon: Icon(isPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.gblue),
              )
            : null,
      ),
    );
  }
}
