import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        return SizedBox(
          height: 100,
          child: Row(
            children: [
              ExtendedImage.network('https://picsum.photos/100'),
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
        );
      },
    );
  }
}
