import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    );
  }
}
