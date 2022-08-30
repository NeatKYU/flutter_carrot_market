import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable()
class Meta {
  @JsonKey(name: 'is_end')
  bool? isEnd;
  @JsonKey(name: 'pageable_count')
  int? pageableCount;
  @JsonKey(name: 'total_count')
  int? totalCount;

  Meta({this.isEnd, this.pageableCount, this.totalCount});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Meta) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      isEnd.hashCode ^ pageableCount.hashCode ^ totalCount.hashCode;
}
