import 'package:flutter/material.dart';
import 'package:carrot_market_by_flutter/screens/start/intro_page.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Center(
            child: IntroPage(),
          ),
          Container(
            color: Colors.accents[2],
          ),
          Container(
            color: Colors.accents[5],
          )
        ],
      ),
    );
  }
}
