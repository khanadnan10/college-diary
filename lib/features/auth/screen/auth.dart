// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                ),
                softWrap: true,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        indicatorColor: Colors.amber,
                        labelColor: Colors.amber,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        onTap: (val) {},
                        tabs: const [
                          Tab(text: 'Log in'),
                          Tab(text: 'Sign up'),
                        ],
                      ),
                      SizedBox(
                        height: 300,
                        child: TabBarView(children: [
                          Text('data'),
                          Text('noh'),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
