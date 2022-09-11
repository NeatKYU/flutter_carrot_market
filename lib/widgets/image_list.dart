import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  const ImageList({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double imageWidth = _size.width / 3 - (common_padding * 2);

    return SizedBox(
      height: _size.width / 3,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(common_padding),
            child: Container(
                width: imageWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.grey,
                    ),
                    Text(
                      '0/10',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )),
          ),
          ...List.generate(
            10,
            (index) => Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: common_padding,
                    top: common_padding,
                    bottom: common_padding,
                  ),
                  child: ExtendedImage.network(
                    'https://picsum.photos/100',
                    width: imageWidth,
                    height: imageWidth,
                    borderRadius: BorderRadius.circular(common_padding_sm),
                    shape: BoxShape.rectangle,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  width: 40,
                  height: 40,
                  child: IconButton(
                    padding: EdgeInsets.all(4),
                    onPressed: () {},
                    icon: Icon(Icons.remove_circle),
                    color: Colors.black38
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
