import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';

class ProfileActivityCountCard extends StatelessWidget {
  final String activityName;
  final int count;

  const ProfileActivityCountCard(
      {super.key, required this.activityName, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0).copyWith(right: 10.0, left: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Pallete.whiteColor.withOpacity(
            0.3,
          ),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 16.0,
              color: Pallete.whiteColor,
            ),
          ),
          Text(
            activityName,
            style: TextStyle(
              fontSize: 12.0,
              color: Pallete.whiteColor.withOpacity(
                0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
