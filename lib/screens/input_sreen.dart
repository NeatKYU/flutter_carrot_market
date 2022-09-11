import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carrot_market_by_flutter/widgets/image_list.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('중고거래 글쓰기'),
        foregroundColor: Colors.black,
        // 닫기 버튼 커스텀
        leading: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          child: Text(
            '닫기',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          onPressed: () => {GoRouter.of(context).go('/')},
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ),
            child: Text(
              '완료',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onPressed: () => {},
          )
        ],
      ),
      body: ImageList(),
    );
  }
}
