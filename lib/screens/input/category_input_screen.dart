import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryInputScreen extends StatelessWidget {
  const CategoryInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카테고리 선택'),
        foregroundColor: Colors.black,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categoryList[index]),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey,
              height: 1,
            );
          },
          itemCount: categoryList.length),
    );
  }
}

const List<String> categoryList = [
  '상의',
  '하의',
  '아우터',
  '신발',
  '양말',
  '모자',
  '속옷',
  '명품'
];
