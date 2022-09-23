import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SmilarItem extends StatelessWidget {
  final ItemModel _itemModel;
  const SmilarItem(this._itemModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/item/${_itemModel.itemKey}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: ExtendedImage.network(
              _itemModel.imageDownloadUrls[0],
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _itemModel.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _itemModel.price.toString() + '원',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
