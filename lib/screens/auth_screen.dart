import 'package:flutter/material.dart';
import 'package:carrot_market_by_flutter/screens/start/intro_page.dart';
import 'package:carrot_market_by_flutter/screens/start/address_page.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  PageController _paegViewContorler = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _paegViewContorler,
        // user가 손가락으로 pageview컨트롤 못하도록 막기
        // physics: NeverScrollableScrollPhysics(),
        children: [
          Center(
            // 여기서 밑으로 컨트롤러 넘겨주면 안됨 나중에 프로바이더 같은거 써야함
            child: IntroPage(_paegViewContorler),
          ),
          AddressPage(),
          Container(
            color: Colors.accents[5],
          )
        ],
      ),
    );
  }
}
