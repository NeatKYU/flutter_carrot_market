import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:carrot_market_by_flutter/model/user_model/user_model.dart';
import 'package:carrot_market_by_flutter/provider/category_provider.dart';
import 'package:carrot_market_by_flutter/provider/select_images_provider.dart';
import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:carrot_market_by_flutter/repo/image_storage.dart';
import 'package:carrot_market_by_flutter/repo/item_service.dart';
import 'package:carrot_market_by_flutter/repo/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:carrot_market_by_flutter/widgets/image_list.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../utils/logger.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool _selectedPrice = false;
  bool _imageUploadLoading = false;
  TextEditingController _moneyController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  Widget _divider = Divider(
    color: Colors.grey,
    endIndent: common_padding,
    indent: common_padding,
    thickness: 1,
    height: 1,
  );

  void setInputPageValue() async {
    setState(() {
      _imageUploadLoading = true;
    });
    UserProvider userProvider = context.read<UserProvider>();
    if (userProvider.user == null) return;

    List<Uint8List> images = context.read<SelectImagesProvider>().images;
    List<String> downloadUrls = await ImageStroage.UploadImages(images);
    String itemKey =
        ImageStroage.createKey(FirebaseAuth.instance.currentUser!.uid);

    ItemModel _itemModel = ItemModel(
      itemKey: itemKey,
      userKey: FirebaseAuth.instance.currentUser!.uid,
      imageDownloadUrls: downloadUrls,
      title: _titleController.text,
      category: context.read<CategoryProvider>().currentCategory,
      price: int.parse(
          _moneyController.text.replaceAll(',', '').replaceAll('???', '')),
      nego: _selectedPrice,
      detail: _detailController.text,
      address: userProvider.userModel!.address,
      geoFirePoint: userProvider.userModel!.geoFirePoint,
      createdDate: DateTime.now(),
    );

    ItemService().createNewItem(_itemModel, itemKey, userProvider.user!.uid);
    GoRouter.of(context).go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('???????????? ?????????'),
        foregroundColor: Colors.black,
        // ?????? ?????? ?????????
        leading: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          child: Text(
            '??????',
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
              '??????',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onPressed: () async {
              setInputPageValue();
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 2),
          child: _imageUploadLoading
              ? LinearProgressIndicator(minHeight: 2)
              : Container(),
        ),
      ),
      body: Column(
        children: [
          ImageList(),
          _divider,
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: '??? ??????',
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
            title: Text(context.watch<CategoryProvider>().currentCategory),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  // ?????? ?????? ??????
                  onChanged: (value) {
                    if (value == '0???') {
                      _moneyController.clear();
                    }
                  },
                  controller: _moneyController,
                  // ???????????? input?????? ?????? ?????? ?????????
                  inputFormatters: [
                    CurrencyInputFormatter(
                      trailingSymbol: '???',
                      mantissaLength: 0,
                    )
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: common_padding),
                    hintText: '?????? ??????(????????????)',
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              TextButton.icon(
                label: Text(
                  '???????????? ??????',
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
            controller: _detailController,
            // null??? ???????????? ????????? ???????????? ????????????
            maxLines: null,
            // ?????? ???????????? ????????? multiline?????? ?????????
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: common_padding),
              hintText: '????????? ????????????.',
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
