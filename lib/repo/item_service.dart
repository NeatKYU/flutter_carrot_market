import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:carrot_market_by_flutter/model/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ItemService {
  static final ItemService _itemService = ItemService._internal();
  factory ItemService() => _itemService;
  ItemService._internal();

  Future createNewItem(
      ItemModel itemModel, String itemKey, String userKey) async {
    DocumentReference<Map<String, dynamic>> itemDocReference =
        FirebaseFirestore.instance.collection('items').doc(itemKey);
    DocumentReference<Map<String, dynamic>> uesrItemDocReference =
        FirebaseFirestore.instance
            .collection('users')
            .doc(userKey)
            .collection('items')
            .doc(itemKey);

    // 아이디가 있는지 없는지 확인 용
    final DocumentSnapshot documentSnapshot = await itemDocReference.get();

    if (!documentSnapshot.exists) {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // transaction을 사용하면 여러개를 한번에 처리가능!!
        transaction.set(itemDocReference, itemModel.toJson());
        transaction.set(uesrItemDocReference, itemModel.toMinJson());
      });
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
