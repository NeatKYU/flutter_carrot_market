import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'results.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  Results? results;

  Address({this.results});

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
  int get hashCode => results.hashCode;
}
