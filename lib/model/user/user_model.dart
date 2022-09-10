import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class UserModel {
  late String userKey;
  late String phoneNumber;
  late String address;
  late num lat;
  late num lon;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  late DocumentReference? reference;
}
