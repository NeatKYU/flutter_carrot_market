import 'package:flutter/material.dart';
import 'package:carrot_market_by_flutter/screens/start/intro_page.dart';
import 'package:carrot_market_by_flutter/screens/start/address_page.dart';
import 'package:carrot_market_by_flutter/screens/start/auth_page.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  PageController _pageViewContorler = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewContorler,
        // user가 손가락으로 pageview컨트롤 못하도록 막기
        // physics: NeverScrollableScrollPhysics(),
        children: [
          Center(
            // 여기서 밑으로 컨트롤러 넘겨주면 안됨 나중에 프로바이더 같은거 써야함
            child: IntroPage(_pageViewContorler),
          ),
          AddressPage(_pageViewContorler),
          AuthPage(),
        ],
      ),
    );
  }
}
