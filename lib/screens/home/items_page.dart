import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
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
              Expanded(
                child: Column(
                  children: [
                    Text('title'),
                    Text('53일전'),
                    Text('5000won'),
                    Expanded(
                      child: Row(
                        children: [],
                      ),
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
