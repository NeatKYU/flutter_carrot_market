import 'dart:async';

import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:latlng/latlng.dart';

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

  Future<List<ItemModel>> getUserItemList(
      String userKey, String itemKey) async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection('users')
            .doc(userKey)
            .collection('items');

    QuerySnapshot<Map<String, dynamic>> snapshots =
        await collectionReference.get();

    List<ItemModel> items = [];

    for (int i = 0; i < snapshots.size; i++) {
      ItemModel itemModel = ItemModel.fromQuerySnapshot(snapshots.docs[i]);
      // 자기 자신 게시글 제거
      if (itemModel.itemKey != itemKey) {
        items.add(itemModel);
      }
    }

    return items;
  }

  Future<List<ItemModel>> getNearByItems(String userKey, LatLng latlng) async {
    final geo = Geoflutterfire();
    // DocumentReference<Map<String, dynamic>> itemDocReference =
    //     FirebaseFirestore.instance.collection('items').doc();

    final itemCol = FirebaseFirestore.instance.collection('items');

    GeoFirePoint center = GeoFirePoint(latlng.latitude, latlng.longitude);
    // 지도상에서 보일 반경
    double radius = 20;
    String field = 'geoFirePoint';

    List<ItemModel> items = [];
    List<DocumentSnapshot<Object?>> snapshots = await geo
        .collection(collectionRef: itemCol)
        .within(
          center: center,
          radius: radius,
          field: field,
        )
        .first;
    print(snapshots);
    // Stream<List<DocumentSnapshot>> stream = geo
    //     .collection(collectionRef: itemCol)
    //     .within(center: center, radius: radius, field: field, strictMode: true);

    // stream.listen((List<DocumentSnapshot> documentList) {
    //   print("Printing DocumentList Data:");
    //   print(documentList[0]!.data());
    //   for (int i = 0; i < documentList.length; i++) {
    //     ItemModel itemModel = ItemModel.fromSnapshot(documentList[i].data());
    //   }
    // });
    for (int i = 0; i < snapshots.length; i++) {
      ItemModel itemModel = ItemModel.fromSnapshot(
          snapshots[i] as DocumentSnapshot<Map<String, dynamic>>);
      items.add(itemModel);
    }

    return items;
  }
}
