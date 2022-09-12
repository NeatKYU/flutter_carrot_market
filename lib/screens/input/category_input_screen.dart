import 'package:carrot_market_by_flutter/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
            final String _value = categoryMapEngToKor.values.elementAt(index);
            return ListTile(
              onTap: () {
                context.read<CategoryProvider>().setNewCategoryWithValue(_value);
                GoRouter.of(context).go('/input');
              },
              title: Text(_value),
              selected: context.read<CategoryProvider>().currentCategory == _value,
              selectedTileColor: Color.fromARGB(255, 178, 197, 207),
              selectedColor: Colors.black,
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey,
              height: 1,
            );
          },
          itemCount: categoryMapEngToKor.length),
    );
  }
}
