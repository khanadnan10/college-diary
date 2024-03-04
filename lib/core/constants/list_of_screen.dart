import 'package:college_diary/features/home/screen/home_screen.dart';
import 'package:college_diary/features/post/screen/add_post.dart';
import 'package:college_diary/features/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';

List<Widget> screens = [
  const HomeScreen(),
  const Center(
    child: Text('Post screen'),
  ),
  const AddPostScreen(),
  const Center(
    child: Text('News screen'),
  ),
  const ProfileScreen(),
];
