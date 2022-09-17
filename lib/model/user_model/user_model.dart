import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  late String userKey;
  late String phoneNumber;
  late String address;
  // late num lat;
  // late num lon;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  DocumentReference? reference;

  UserModel({
    required this.userKey,
    required this.phoneNumber,
    required this.address,
    // required this.lat,
    // required this.lon,
    required this.geoFirePoint,
    required this.createdDate,
    this.reference,
  });

  factory UserModel.fromJson(
      Map<String, dynamic> json, String userKey, DocumentReference reference) {
    return _$UserModelFromJson(json, userKey, reference);
  }

  // usermodel 저장하기 위한 로직
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel.fromJson(
        snapshot.data()!, snapshot.id, snapshot.reference);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
