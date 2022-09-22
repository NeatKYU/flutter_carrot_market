import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:carrot_market_by_flutter/repo/item_service.dart';
import 'package:carrot_market_by_flutter/screens/item/smilar_item.dart';
import 'package:carrot_market_by_flutter/utils/calculation_time.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemKey;

  const ItemDetailScreen(this.itemKey, {super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();

  bool isAppbarCollapsed = false;
  num? _statusBarHeight;
  Size? _size;

  // 스크롤링 얼마나 되냐에 따라 상태값 설정
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_size == null || _statusBarHeight == null) return;
      if (isAppbarCollapsed) {
        // kToolbarHeight = app bar 크기
        if (_scrollController.offset <
            _size!.width - _statusBarHeight! - kToolbarHeight) {
          setState(() {
            isAppbarCollapsed = false;
          });
        }
      } else {
        if (_scrollController.offset >
            _size!.width - _statusBarHeight! - kToolbarHeight) {
          setState(() {
            isAppbarCollapsed = true;
          });
        }
      }
    });
    super.initState();
  }

  // 컨트롤러 만들어줄 때 마다 이렇게 dispose하는 습관을 만들자
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _divider() {
    return Divider(
      indent: common_padding,
      endIndent: common_padding,
      height: 1,
      color: Colors.grey,
    );
  }

  Widget _gap(double paramWidth, double paramHeight) {
    return SizedBox(
      width: paramWidth,
      height: paramHeight,
    );
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
              _size = MediaQuery.of(context).size;
              // appbar 위 부분에 있는 status bar의 크기를 구함
              _statusBarHeight = MediaQuery.of(context).padding.top;
              int _itemLength = itemModel.imageDownloadUrls.length;

              return Stack(
                children: [
                  Scaffold(
                    bottomNavigationBar: SafeArea(
                      bottom: true,
                      top: false,
                      child: Container(
                        height: 80,
                        padding: EdgeInsets.all(common_padding_sm),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_border_outlined,
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                              indent: 2,
                              endIndent: 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('45000원'),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '가격제안불가',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            TextButton(
                              onPressed: () {},
                              child: Text('채팅으로 거래하기'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
                          expandedHeight: _size!.width,
                          pinned: true,
                          foregroundColor: Colors.black,
                          flexibleSpace: FlexibleSpaceBar(
                            // 안드로이드 일 경우 타이틀이 왼쪽으로 치우쳐짐이 있을 수 있음
                            centerTitle: true,
                            title: SmoothPageIndicator(
                              controller: _pageController, // PageController
                              count: _itemLength,
                              effect: WormEffect(
                                dotHeight: 10,
                                dotWidth: 10,
                                activeDotColor: Theme.of(context).primaryColor,
                              ), // your preferred effect
                              onDotClicked: (index) {},
                            ),
                            background: PageView.builder(
                              controller: _pageController,
                              itemBuilder: (context, index) {
                                return ExtendedImage.network(
                                  itemModel.imageDownloadUrls[index],
                                  fit: BoxFit.cover,
                                );
                              },
                              itemCount: _itemLength,
                            ),
                          ),
                        ),
                        // SliverToBoxAdapter(
                        //   child: Container(
                        //     height: _size!.height * 2,
                        //     child: Center(
                        //       child: Text(widget.itemKey),
                        //     ),
                        //   ),
                        // )
                        SliverList(
                          delegate: SliverChildListDelegate([
                            _userSection(),
                            _divider(),
                            Padding(
                              padding: const EdgeInsets.all(common_padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    itemModel.title,
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  _gap(0, 10),
                                  Row(
                                    children: [
                                      Text(
                                        itemModel.category,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      _gap(5, 0),
                                      Text(
                                        CalculationTime.getTimeDiff(
                                          itemModel.createdDate,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                  _gap(0, 10),
                                  Text(
                                    itemModel.detail,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  _gap(0, 10),
                                  Text(
                                    '조회 33',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            ),
                            _divider(),
                            Padding(
                              padding: const EdgeInsets.all(common_padding_sm),
                              child: TextButton(
                                onPressed: () {},
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '이 게시글 신고하기',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                            _divider(),
                            Padding(
                              padding: const EdgeInsets.all(common_padding),
                              child: Row(
                                children: [
                                  Text(
                                    '무무님의 판매상품',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      '더보기',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.all(common_padding_sm),
                          sliver: SliverGrid.count(
                            crossAxisCount: 2,
                            childAspectRatio: 5 / 6,
                            mainAxisSpacing: common_padding_sm,
                            crossAxisSpacing: common_padding_sm,
                            children: List.generate(
                              10,
                              (index) => SmilarItem(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 그라데이션 효과 주려고 넣은 컨테이너 그라데이션 필요없으면 없어도됨
                  // Positioned(
                  //     top: 0,
                  //     left: 0,
                  //     right: 0,
                  //     height: kToolbarHeight + _statusBarHeight!,
                  //     child: Container(
                  //       height: kToolbarHeight + _statusBarHeight!,
                  //       decoration: BoxDecoration(
                  //           gradient: LinearGradient(
                  //               begin: Alignment.topCenter,
                  //               end: Alignment.bottomCenter,
                  //               colors: isAppbarCollapsed
                  //                   ? [Colors.white]
                  //                   : [
                  //                       Colors.black38,
                  //                       Colors.black38,
                  //                       Colors.transparent
                  //                     ])),
                  //     )),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: kToolbarHeight + _statusBarHeight!,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        systemOverlayStyle: isAppbarCollapsed
                            ? SystemUiOverlayStyle.dark
                            : SystemUiOverlayStyle.light,
                        backgroundColor:
                            isAppbarCollapsed ? Colors.white : Colors.black12,
                        // 그라데이션 사용 할 때는 투명색으로 해줘야함
                        // backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor:
                            isAppbarCollapsed ? Colors.black : Colors.white,
                      ),
                    ),
                  )
                ],
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _userSection() {
    return Padding(
      padding: const EdgeInsets.all(common_padding),
      child: Row(
        children: [
          ExtendedImage.network(
            'https://picsum.photos/50',
            width: _size!.width / 10,
            height: _size!.width / 10,
            fit: BoxFit.cover,
            shape: BoxShape.circle,
          ),
          _gap(common_padding, 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('우치치', style: TextStyle(fontSize: 16)),
              _gap(0, 10),
              Text('배곧동'),
            ],
          ),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FittedBox(
                          child: Text(
                            '37.3 C',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                        _gap(0, 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: LinearProgressIndicator(
                            minHeight: 4,
                            value: 0.373,
                            color: Colors.blueAccent,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _gap(10, 0),
                  Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.blueAccent,
                  )
                ],
              ),
              _gap(0, 10),
              Text(
                '매너온도',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          )
        ],
      ),
    );
  }
}
