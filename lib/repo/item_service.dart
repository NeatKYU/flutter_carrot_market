import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ItemService {
  static final ItemService _itemService = ItemService._internal();
  factory ItemService() => _itemService;
  ItemService._internal();

  Future createNewItem(Map<String, dynamic> json, String itemKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('items').doc(itemKey);

    // 아이디가 있는지 없는지 확인 용
    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if (!documentSnapshot.exists) {
      documentReference.set(json);
    }
  }

  Future<ItemModel> getItemModel(String itemKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('items').doc(itemKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();

    ItemModel itemModel = ItemModel.fromSnapshot(documentSnapshot);

    return itemModel;
  }

  Future<List<ItemModel>> getItemList() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('items');

    QuerySnapshot<Map<String, dynamic>> snapshots =
        await collectionReference.get();

    List<ItemModel> items = [];

    for (int i = 0; i < snapshots.size; i++) {
      items.add(ItemModel.fromQuerySnapshot(snapshots.docs[i]));
    }

    return items;
  }
}
