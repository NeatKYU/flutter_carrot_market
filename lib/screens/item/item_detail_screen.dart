import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:carrot_market_by_flutter/repo/item_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemKey;

  const ItemDetailScreen(this.itemKey, {super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  PageController _pageController = PageController();

  // 컨트롤러 만들어줄 때 마다 이렇게 dispose하는 습관을 만들자
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ItemModel>(
      future: ItemService().getItemModel(widget.itemKey),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ItemModel itemModel = snapshot.data!;
          return LayoutBuilder(
            builder: (context, constraints) {
              Size _size = MediaQuery.of(context).size;
              int _itemLength = itemModel.imageDownloadUrls.length;
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: _size.width,
                      pinned: true,
                      foregroundColor: Colors.black,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              itemBuilder: (context, index) {
                                return ExtendedImage.network(
                                  itemModel.imageDownloadUrls[index],
                                  fit: BoxFit.cover,
                                );
                              },
                              itemCount: _itemLength,
                            ),
                            Positioned(
                              bottom: common_padding,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: SmoothPageIndicator(
                                    controller:
                                        _pageController, // PageController
                                    count: _itemLength,
                                    effect: WormEffect(
                                      dotHeight: 10,
                                      dotWidth: 10,
                                      activeDotColor:
                                          Theme.of(context).primaryColor,
                                    ), // your preferred effect
                                    onDotClicked: (index) {}),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: _size.height * 2,
                        child: Center(
                          child: Text(widget.itemKey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
