import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:carrot_market_by_flutter/constants/common_size.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              '전화번호 로그인',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(common_padding),
            child: Column(
              children: [
                Row(
                  children: [
                    // image,
                    ExtendedImage.asset(
                      'assets/images/padlock.png',
                      width: size.width * 0.16,
                      height: size.width * 0.16,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    // text
                    Text('고기 마켓은 휴대폰 번호로 가입해요\n 번호는 안전하게 보관되며\n 어디에도 공개되지 않아요.')
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
