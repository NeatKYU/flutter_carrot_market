import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:carrot_market_by_flutter/widgets/image_list.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool _selectedPrice = false;
  TextEditingController _moneyController = TextEditingController();

  Widget _divider = Divider(
    color: Colors.grey,
    endIndent: common_padding,
    indent: common_padding,
    thickness: 1,
    height: 1,
  );

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
      body: Column(
        children: [
          ImageList(),
          _divider,
          TextFormField(
            decoration: InputDecoration(
              hintText: '글 제목',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              contentPadding: EdgeInsets.symmetric(
                horizontal: common_padding,
              ),
            ),
          ),
          _divider,
          ListTile(
            onTap: () {
              GoRouter.of(context).go('/input/category');
            },
            dense: true,
            title: Text('선택'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  // 남는 글자 삭제
                  onChanged: (value) {
                    if (value == '0원') {
                      _moneyController.clear();
                    }
                  },
                  controller: _moneyController,
                  // 돈형식의 input값을 받기 위한 포맷터
                  inputFormatters: [
                    CurrencyInputFormatter(
                      trailingSymbol: '원',
                      mantissaLength: 0,
                    )
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: common_padding),
                    hintText: '가격 입력(선택사항)',
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              TextButton.icon(
                label: Text(
                  '가격제안 받기',
                  style: TextStyle(
                    color: _selectedPrice
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  ),
                ),
                icon: Icon(
                  _selectedPrice
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  color: _selectedPrice
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                  size: 22,
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.only(right: common_padding),
                ),
                onPressed: () {
                  setState(() {
                    _selectedPrice = !_selectedPrice;
                  });
                },
              ),
            ],
          ),
          _divider,
          TextFormField(
            // null로 넘겨주면 몇줄을 입력하든 상관없음
            maxLines: null,
            // 가상 키보드의 형식이 multiline으로 변경됨
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: common_padding),
              hintText: '내용을 써주세요.',
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
