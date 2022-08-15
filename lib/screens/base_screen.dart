import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String stateValue = '';

  const BaseScreen({
    Key? key,
    required String stateValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Base screen'),
      ),
      body: Text(stateValue),
    );
  }
}
