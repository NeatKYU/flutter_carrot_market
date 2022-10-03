import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:carrot_market_by_flutter/repo/item_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/item_model/item_model.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<ItemModel> _items = [];
  bool isInit = false;

  @override
  void initState() {
    if (!isInit) {
      _onRefresh();
      isInit = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        final imageSize = size.width / 4;

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child:
              (_items.isNotEmpty) ? _listView(imageSize) : _shimmerListView(),
        );
      },
    );
  }

  Future _onRefresh() async {
    _items.clear();
    _items.addAll(await ItemService().getItemList());
    setState(() {});
  }

  // 원래 보여줘야할 리스트
  Widget _listView(double imageSize) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.all(common_padding),
        itemCount: _items.length,
        separatorBuilder: (context, idnex) {
          return const Divider(
            height: common_padding * 2,
            color: Colors.blueGrey,
            thickness: 1,
            indent: common_padding_sm,
            endIndent: common_padding_sm,
          );
        },
        itemBuilder: (context, index) {
          ItemModel item = _items[index];
          return InkWell(
            onTap: () {
              // 데이터 베이스에 집어넣기~
              // UserService().firestoreTest();

              // 데이터 베이스에서 가져오기~
              // UserService().firestoreGetTest();

              // go item detail page
              GoRouter.of(context).go('/item/${item.itemKey}');
            },
            child: SizedBox(
              height: imageSize,
              child: Row(
                children: [
                  SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: ExtendedImage.network(
                      item.imageDownloadUrls[0],
                      fit: BoxFit.cover,
                      // 이거 지정 안해주면 보더 적용 안됨
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    width: common_padding,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title,
                            style: Theme.of(context).textTheme.subtitle1),
                        Text('53일전',
                            style: Theme.of(context).textTheme.subtitle2),
                        Text('${item.price}원'),
                        // row가 내려가게 expanded로 전부 차지하게 해줌
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 18,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Row(
                                  children: [
                                    Icon(CupertinoIcons.chat_bubble_2),
                                    Text('23'),
                                    Icon(CupertinoIcons.heart),
                                    Text('30'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// 잠시 보여줘야할 shimmer list
  Widget _shimmerListView() {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 185, 180, 180),
      highlightColor: Color.fromARGB(255, 197, 197, 197),
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.all(common_padding),
        itemCount: 10,
        separatorBuilder: (context, idnex) {
          return const Divider(
            height: common_padding * 2,
            color: Colors.blueGrey,
            thickness: 1,
            indent: common_padding_sm,
            endIndent: common_padding_sm,
          );
        },
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100,
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                  ),
                ),
                const SizedBox(
                  width: common_padding,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 18,
                        width: 120,
                        color: Colors.white,
                      ),
                      SizedBox(height: 3),
                      Container(
                        height: 18,
                        width: 100,
                        color: Colors.white,
                      ),
                      SizedBox(height: 3),
                      Container(
                        height: 18,
                        width: 150,
                        color: Colors.white,
                      ),
                      // row가 내려가게 expanded로 전부 차지하게 해줌
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 18,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Row(
                                children: [
                                  Container(
                                    height: 12,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
