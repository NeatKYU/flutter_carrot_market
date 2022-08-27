import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carrot_market_by_flutter/api/address_service.dart';
import 'package:carrot_market_by_flutter/model/address/address.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  Address? _addressModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // safearea에 있는 padding기능?
      minimum: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _addressController,
            onFieldSubmitted: (keyword) async {
              _addressModel = await AddressService().getAddress(keyword);
              setState(() {});
            },
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
                  // final keyword = _addressController.text;
                  // if (keyword.isNotEmpty) {
                  //   AddressService().getAddress(keyword);
                  // }
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
                if (_addressModel == null ||
                    _addressModel!.results == null ||
                    _addressModel!.results!.juso == null ||
                    _addressModel!.results!.juso![index].roadAddr == null) {
                  return Container();
                }
                logger.d('list view = ${_addressModel!.results}');
                return ListTile(
                  leading: Icon(Icons.image),
                  trailing: ExtendedImage.asset('assets/images/pos.png'),
                  // title: Text('address $index'),
                  title:
                      Text(_addressModel!.results!.juso![index].roadAddr ?? ''),
                  subtitle: Text('subtitle $index'),
                );
              },
              itemCount: (_addressModel == null ||
                      _addressModel!.results == null ||
                      _addressModel!.results!.juso == null)
                  ? 0
                  : _addressModel!.results!.juso!.length,
            ),
          )
        ],
      ),
    );
  }
}
