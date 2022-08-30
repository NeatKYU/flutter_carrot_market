import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'document.dart';
import 'meta.dart';

part 'convert_address.g.dart';

@JsonSerializable()
class ConvertAddress {
  Meta? meta;
  List<Document>? documents;

  ConvertAddress({this.meta, this.documents});

  factory ConvertAddress.fromJson(Map<String, dynamic> json) {
    return _$ConvertAddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConvertAddressToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ConvertAddress) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => meta.hashCode ^ documents.hashCode;
}
