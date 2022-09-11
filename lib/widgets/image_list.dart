import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  const ImageList({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return SizedBox(
      height: _size.width / 3,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(common_padding),
            child: Container(
                width: _size.width / 3 - (common_padding*2),
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
          Container(
            width: _size.width / 3,
            color: Colors.blueGrey,
          ),
          Container(
            width: _size.width / 3,
            color: Colors.amberAccent,
          ),
          Container(
            width: _size.width / 3,
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
