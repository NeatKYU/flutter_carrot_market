import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'document.dart';
import 'meta.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  List<Document>? documents;
  Meta? meta;

  Address({this.documents, this.meta});

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Address) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => documents.hashCode ^ meta.hashCode;
}
