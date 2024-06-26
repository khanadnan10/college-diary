// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:college_diary/theme/pallete.dart';

class CTextField extends StatelessWidget {
  final TextEditingController emailController;
  final String hintText;
  final TextInputType? keyboardInputType;
  final VoidCallback? onTap;
  const CTextField({
    Key? key,
    required this.emailController,
    required this.hintText,
    this.keyboardInputType = TextInputType.multiline,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardInputType,
      controller: emailController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Pallete.greyColor.withOpacity(0.3),
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Pallete.greyColor.withOpacity(0.3),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Pallete.greyColor,
          ),
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Pallete.greyColor.withOpacity(0.3),
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText can't be empty";
        }
        return null;
      },
    );
  }
}
