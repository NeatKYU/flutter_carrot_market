import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'road_address.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {
  @JsonKey(name: 'road_address')
  RoadAddress? roadAddress;
  Address? address;

  Document({this.roadAddress, this.address});

  factory Document.fromJson(Map<String, dynamic> json) {
    return _$DocumentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Document) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => roadAddress.hashCode ^ address.hashCode;
}
