import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'common.dart';
import 'juso.dart';

part 'results.g.dart';

@JsonSerializable()
class Results {
  Common? common;
  List<Juso>? juso;

  Results({this.common, this.juso});

  factory Results.fromJson(Map<String, dynamic> json) {
    return _$ResultsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Results) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => common.hashCode ^ juso.hashCode;
}
