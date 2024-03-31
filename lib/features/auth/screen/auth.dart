// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:college_diary/core/widgets/custom_elevated_button.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/core/routes/route_name.dart';
import 'package:college_diary/core/utils.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:college_diary/core/widgets/custom_text_field.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _enrollmentController = TextEditingController();

  bool isVerified = false;

  void verifyUser(context) {
    if (_signupFormKey.currentState!.validate()) {
      final verified = Routemaster.of(context).push(
        RouteName.invitationVerification,
      );
      verified.result.then((value) {
        if (value == true) {
          isVerified = true;
          showSnackBar(context, 'One more step to continue.');
        }
      });
    }
  }

  void signupuser() {
    ref.read(authControllerProvider.notifier).signupUser(
        context: context,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
        enrollmentNumber: _enrollmentController.text.trim());
  }

  void signinUser() async {
    if (_loginFormKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).signin(
            context: context,
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

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

    final isLoading = ref.watch(authControllerProvider);
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Loader()
            : SingleChildScrollView(
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
                              tabs: const [
                                Tab(text: 'Log in'),
                                Tab(text: 'Sign up'),
                              ],
                            ),
                            SizedBox(
                              height: screenSize,
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 24.0),
                                    child: Form(
                                      key: _loginFormKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            emailController:
                                                _passwordController,
                                          ),
                                          SizedBox(height: 20),
                                          CElevatedButton(
                                            text: 'Login',
                                            onPressed: signinUser,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: Form(
                                          key: _signupFormKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Name'),
                                              CTextField(
                                                hintText: 'College Diary',
                                                emailController:
                                                    _nameController,
                                              ),
                                              SizedBox(height: 20),
                                              Text('Email'),
                                              CTextField(
                                                hintText:
                                                    'collegediary@email.com',
                                                emailController:
                                                    _emailController,
                                              ),
                                              SizedBox(height: 20),
                                              Text('Password'),
                                              CTextField(
                                                hintText: 'Password',
                                                emailController:
                                                    _passwordController,
                                              ),
                                              SizedBox(height: 20),
                                              Text('Phone Number'),
                                              CTextField(
                                                hintText: '+91- 9876543210',
                                                emailController:
                                                    _phoneNumberController,
                                                keyboardInputType:
                                                    TextInputType.phone,
                                              ),
                                              SizedBox(height: 20),
                                              Text('Enrollment'),
                                              CTextField(
                                                hintText: '0115CSXXXXX',
                                                emailController:
                                                    _enrollmentController,
                                              ),
                                              SizedBox(height: 20),
                                              !isVerified
                                                  ? CElevatedButton(
                                                      text: 'Verify',
                                                      onPressed: () =>
                                                          verifyUser(context),
                                                    )
                                                  : CElevatedButton(
                                                      text: 'Sign up',
                                                      onPressed: signupuser,
                                                    ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
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
