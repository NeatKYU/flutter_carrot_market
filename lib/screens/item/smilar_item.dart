import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SmilarItem extends StatelessWidget {
  const SmilarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: ExtendedImage.network(
            'https://picsum.photos/100',
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'title',
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
          '4500원',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
