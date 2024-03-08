
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';

class CElevatedButton extends StatelessWidget {
  const CElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Pallete.blueColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Pallete.whiteColor,
          ),
        ),
      ),
    );
  }
}