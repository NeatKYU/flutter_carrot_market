import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  void pressButton() => {logger.d('click button!')};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              '고기 마켓',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Container(child: ExtendedImage.asset('assets/images/map.jpeg')),
            const Text(
              '우리 동네 중고 직거래 고기 마켓',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('고기 마켓은 동네 중고 직거래 마켓이에요. \n내 동네를 설정하고 시작해보세요.'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: pressButton,
                  child: Text('내 동네 설정하고 시작하기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
