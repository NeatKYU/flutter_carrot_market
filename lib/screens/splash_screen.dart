import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('splash screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExtendedImage.asset('assets/images/counterside.jpg'),
            CircularProgressIndicator(),
          ],
        ),
      )
    );
  }
}
