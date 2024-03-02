// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:college_diary/core/common/widgets/custom_elevated_button.dart';
import 'package:college_diary/core/route_name.dart';
import 'package:flutter/material.dart';

import 'package:college_diary/core/common/widgets/custom_text_field.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/widgets.dart';
import 'package:routemaster/routemaster.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _enrollmentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _enrollmentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Stay engaged",
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  "The best way to get the most out of our app is to participate actively.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Pallete.greyColor.withOpacity(0.5),
                  ),
                  softWrap: true,
                ),
                SizedBox(height: 20),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        indicatorColor: Pallete.blueColor,
                        labelColor: Pallete.blueColor,
                        dividerColor: Colors.transparent,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        // onTap: (val) {},
                        tabs: const [
                          Tab(text: 'Log in'),
                          Tab(text: 'Sign up'),
                        ],
                      ),
                      SizedBox(
                        height: screenSize,
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                              child: Form(
                                key: _loginFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email'),
                                    CTextField(
                                      hintText: 'collegediary@email.com',
                                      emailController: _emailController,
                                      keyboardInputType:
                                          TextInputType.emailAddress,
                                    ),
                                    SizedBox(height: 20),
                                    Text('Password'),
                                    CTextField(
                                      hintText: 'Password',
                                      emailController: _passwordController,
                                    ),
                                    SizedBox(height: 20),
                                    CElevatedButton(
                                      text: 'Login',
                                      onPressed: () => Routemaster.of(context)
                                          .push(RouteName.homeScreen),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                              child: Form(
                                key: _signupFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name'),
                                    CTextField(
                                      hintText: 'College Diary',
                                      emailController: _nameController,
                                    ),
                                    SizedBox(height: 20),
                                    Text('Email'),
                                    CTextField(
                                      hintText: 'collegediary@email.com',
                                      emailController: _emailController,
                                    ),
                                    SizedBox(height: 20),
                                    Text('Password'),
                                    CTextField(
                                      hintText: 'Password',
                                      emailController: _passwordController,
                                    ),
                                    SizedBox(height: 20),
                                    Text('Phone Number'),
                                    CTextField(
                                      hintText: '+91- 9876543210',
                                      emailController: _phoneNumberController,
                                      keyboardInputType: TextInputType.phone,
                                    ),
                                    SizedBox(height: 20),
                                    Text('Enrollment'),
                                    CTextField(
                                      hintText: '0115CSXXXXX',
                                      emailController: _enrollmentController,
                                    ),
                                    SizedBox(height: 20),
                                    CElevatedButton(
                                      text: 'Verify & Sign up',
                                      onPressed: () =>
                                          Routemaster.of(context).push(
                                        RouteName.invitationVerification,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
