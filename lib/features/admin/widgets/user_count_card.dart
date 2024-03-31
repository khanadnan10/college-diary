import 'package:flutter/material.dart';

class UserCountCard extends StatelessWidget {
  const UserCountCard(
      {Key? key,
      required this.text,
      required this.count,
      this.onTap,
      this.color = const Color(0xff3370E5)})
      : super(key: key);

  final String text;
  final int count;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: color.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0).copyWith(top: 24, bottom: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.0,
                  color: color,
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
