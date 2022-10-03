import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        foregroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            child: TextFormField(
              controller: _searchController,
              onFieldSubmitted: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: '검색어를 입력하세요.',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(_searchController.text),
            );
          }),
          separatorBuilder: ((context, index) {
            return Divider(
              color: Colors.lightGreen,
              height: 1,
            );
          }),
          itemCount: 5),
    );
  }
}
