import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';

class CTextFieldFilled extends StatelessWidget {
  const CTextFieldFilled({
    super.key,
    required TextEditingController titleController,
    required String hintText,
    this.maxLine = 1,
  })  : _titleController = titleController,
        _hintText = hintText;

  final TextEditingController _titleController;
  final String _hintText;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        hintText: _hintText,
        hintStyle: TextStyle(
          color: Pallete.greyColor.withOpacity(0.3),
          fontWeight: FontWeight.w400,
        ),
        focusColor: Pallete.greyColor.withOpacity(0.1),
        fillColor: Pallete.greyColor.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Pallete.greyColor.withOpacity(0.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Pallete.greyColor.withOpacity(0.1),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Pallete.greyColor.withOpacity(0.0),
          ),
        ),
      ),
      maxLines: maxLine,
    );
  }
}
