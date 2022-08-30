import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'road_address.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {
  dynamic address;
  @JsonKey(name: 'address_name')
  String? addressName;
  @JsonKey(name: 'address_type')
  String? addressType;
  @JsonKey(name: 'road_address')
  RoadAddress? roadAddress;
  String? x;
  String? y;

  Document({
    this.address,
    this.addressName,
    this.addressType,
    this.roadAddress,
    this.x,
    this.y,
  });

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
  int get hashCode =>
      address.hashCode ^
      addressName.hashCode ^
      addressType.hashCode ^
      roadAddress.hashCode ^
      x.hashCode ^
      y.hashCode;
}
