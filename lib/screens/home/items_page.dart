import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:carrot_market_by_flutter/repo/user_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: (snapshot.connectionState == ConnectionState.done)
              ? _listView()
              : _shimmerListView(),
        );
      },
    );
  }
}

// 원래 보여줘야할 리스트
ListView _listView() {
  return ListView.separated(
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
      return InkWell(
        onTap: () {
          // 데이터 베이스에 집어넣기~
          // UserService().firestoreTest();

          // 데이터 베이스에서 가져오기~
          // UserService().firestoreGetTest();
        },
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              ExtendedImage.network(
                'https://picsum.photos/100',
                // 이거 지정 안해주면 보더 적용 안됨
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(
                width: common_padding,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title', style: Theme.of(context).textTheme.subtitle1),
                    Text('53일전', style: Theme.of(context).textTheme.subtitle2),
                    Text('5000won'),
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
