import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageList extends StatefulWidget {
  const ImageList({super.key});

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  List<XFile> _images = [];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double imageWidth = _size.width / 3 - (common_padding * 2);

    return SizedBox(
      height: _size.width / 3,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            // 사진 추가하기 버튼
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final List<XFile>? images = await _picker.pickMultiImage();
              if (images != null && images.isNotEmpty) {
                _images.clear();
                _images.addAll(images);
                // setState를 해주지않으면 리스트가 반영이 안됨...
                setState(() {});
              }
            },
            child: Padding(
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
          ),
          ...List.generate(
            _images.length,
            (index) => Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: common_padding,
                    top: common_padding,
                    bottom: common_padding,
                  ),
                  child: FutureBuilder<Uint8List>(
                      future: _images[index].readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ExtendedImage.memory(
                            snapshot.data!,
                            width: imageWidth,
                            height: imageWidth,
                            borderRadius:
                                BorderRadius.circular(common_padding_sm),
                            shape: BoxShape.rectangle,
                          );
                        } else {
                          return Container(
                            width: imageWidth,
                            height: imageWidth,
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
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
                      color: Colors.black38),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
