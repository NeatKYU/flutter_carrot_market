import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carrot_market_by_flutter/api/address_service.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // safearea에 있는 padding기능?
      minimum: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: [
          TextFormField(
            // icon은 inputdecoration에 있는 icon을 사용
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: '도로명으로 검색',
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
              // 아이콘의 간격 설정?
              prefixIconConstraints: BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              // textformField의 밑줄 설정
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                icon: Icon(
                  CupertinoIcons.compass,
                  color: Colors.white,
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: Size(10, 48),
                ),
                onPressed: () {
                  AddressService().getAddress('영등포');
                },
                label: Text(
                  '현재위치로 찾기',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.image),
                  trailing: ExtendedImage.asset('assets/images/pos.png'),
                  title: Text('address $index'),
                  subtitle: Text('subtitle $index'),
                );
              },
              itemCount: 30,
            ),
          )
        ],
      ),
    );
  }
}
