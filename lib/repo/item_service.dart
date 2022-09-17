import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  // user model 상태관리를 위한 로직
  Future<ItemModel> getItemModel(String itemKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('items').doc(itemKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();

    ItemModel itemModel = ItemModel.fromSnapshot(documentSnapshot);

    return itemModel;
  }
}
