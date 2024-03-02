// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:college_diary/theme/pallete.dart';

class CTextField extends StatelessWidget {
  const CTextField({
    Key? key,
    required TextEditingController emailController,
    required String hintText,
    this.keyboardInputType,
  })  : _emailController = emailController,
        _hintText = hintText;

  final TextEditingController _emailController;
  final String _hintText;
  final TextInputType? keyboardInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardInputType ?? TextInputType.multiline,
      controller: _emailController,
      decoration: InputDecoration(
        hintText: _hintText,
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
    );
  }
}
