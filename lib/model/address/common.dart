import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common.g.dart';

@JsonSerializable()
class Common {
  String? errorMessage;
  String? countPerPage;
  String? totalCount;
  String? errorCode;
  String? currentPage;

  Common({
    this.errorMessage,
    this.countPerPage,
    this.totalCount,
    this.errorCode,
    this.currentPage,
  });

  factory Common.fromJson(Map<String, dynamic> json) {
    return _$CommonFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommonToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Common) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      errorMessage.hashCode ^
      countPerPage.hashCode ^
      totalCount.hashCode ^
      errorCode.hashCode ^
      currentPage.hashCode;
}
