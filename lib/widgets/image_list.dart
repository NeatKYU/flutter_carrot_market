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
  List<Uint8List> _images = [];

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
              // image 퀄리티 낮춰주는 옵션도 있음 너무 크면 돈 많이 나갈 수 있음
              final List<XFile>? images =
                  await _picker.pickMultiImage(imageQuality: 3);
              if (images != null && images.isNotEmpty) {
                _images.clear();
                // map을 이용해서 list를 만들면 왜인지는 모르겠지만 잘 안된다...
                // images.map((e) async => {_images.add(await (e.readAsBytes()))});
                images.forEach(((element) async {
                  _images.add(await element.readAsBytes());
                }));
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
                  child: ExtendedImage.memory(
                    _images[index],
                    width: imageWidth,
                    height: imageWidth,
                    // 이미지를 박스 크기에 맞춰서 보여준다.
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(common_padding_sm),
                    shape: BoxShape.rectangle,
                    loadStateChanged: (state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.loading:
                          return Container(
                            width: imageWidth,
                            height: imageWidth,
                            padding: EdgeInsets.all(imageWidth / 3),
                            child: CircularProgressIndicator(),
                          );
                        case LoadState.completed:
                          return null;
                        case LoadState.failed:
                          return Icon(Icons.cancel_outlined);
                      }
                    },
                  ),
                ),
                // 삭제 버튼
                Positioned(
                  top: 0,
                  right: 0,
                  width: 40,
                  height: 40,
                  child: IconButton(
                      padding: EdgeInsets.all(4),
                      onPressed: () {
                        setState(() {
                          _images.removeAt(index);
                        });
                      },
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
