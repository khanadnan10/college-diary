import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';

class CTextFieldFilled extends StatelessWidget {
  const CTextFieldFilled({
    super.key,
    required TextEditingController controller,
    String? hintText,
    this.style,
    this.maxLine = 1,
    this.readOnly,
    this.keyboardType,
    this.validator,
  })  : _titleController = controller,
        _hintText = hintText;

  final TextEditingController _titleController;
  final String? _hintText;
  final int maxLine;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      controller: _titleController,
      style: readOnly != true
          ? style
          : TextStyle(
              color: Pallete.greyColor.withOpacity(0.5),
            ),
      keyboardType: keyboardType,
      validator: validator,
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
