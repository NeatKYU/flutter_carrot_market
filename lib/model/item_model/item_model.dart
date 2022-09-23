import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  late String itemKey;
  late String userKey;
  late List<String> imageDownloadUrls;
  late String title;
  late String category;
  late int price;
  late bool nego;
  late String detail;
  late String address;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  late DocumentReference? reference;

  ItemModel({
    required this.itemKey,
    required this.userKey,
    required this.imageDownloadUrls,
    required this.title,
    required this.category,
    required this.price,
    required this.nego,
    required this.detail,
    required this.address,
    required this.geoFirePoint,
    required this.createdDate,
    this.reference,
  });

  ItemModel.min({
    required this.imageDownloadUrls,
    required this.title,
    required this.price,
  });

  factory ItemModel.fromJson(
      Map<String, dynamic> json, String itemKey, DocumentReference reference) {
    return _$ItemModelFromJson(json, itemKey, reference);
  }

  factory ItemModel.fromMinJson(
      Map<String, dynamic> json, String itemKey, DocumentReference reference) {
    return _$ItemModelFromMinJson(json, itemKey);
  }

  factory ItemModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ItemModel.fromJson(
        snapshot.data()!, snapshot.id, snapshot.reference);
  }

  factory ItemModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ItemModel.fromJson(snapshot.data(), snapshot.id, snapshot.reference);
  }

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
  Map<String, dynamic> toMinJson() => _$ItemModelToMinJson(this);
}
