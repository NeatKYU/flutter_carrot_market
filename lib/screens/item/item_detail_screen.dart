import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:flutter/material.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemKey;

  const ItemDetailScreen(this.itemKey, {super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('item detail'),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Text(widget.itemKey),
      ),
    );
  }
}
