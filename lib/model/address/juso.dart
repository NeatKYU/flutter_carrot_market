import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'juso.g.dart';

@JsonSerializable()
class Juso {
  String? detBdNmList;
  String? engAddr;
  String? rn;
  String? emdNm;
  String? zipNo;
  String? roadAddrPart2;
  String? emdNo;
  String? sggNm;
  String? jibunAddr;
  String? siNm;
  String? roadAddrPart1;
  String? bdNm;
  String? admCd;
  String? udrtYn;
  String? lnbrMnnm;
  String? roadAddr;
  String? lnbrSlno;
  String? buldMnnm;
  String? bdKdcd;
  String? liNm;
  String? rnMgtSn;
  String? mtYn;
  String? bdMgtSn;
  String? buldSlno;

  Juso({
    this.detBdNmList,
    this.engAddr,
    this.rn,
    this.emdNm,
    this.zipNo,
    this.roadAddrPart2,
    this.emdNo,
    this.sggNm,
    this.jibunAddr,
    this.siNm,
    this.roadAddrPart1,
    this.bdNm,
    this.admCd,
    this.udrtYn,
    this.lnbrMnnm,
    this.roadAddr,
    this.lnbrSlno,
    this.buldMnnm,
    this.bdKdcd,
    this.liNm,
    this.rnMgtSn,
    this.mtYn,
    this.bdMgtSn,
    this.buldSlno,
  });

  factory Juso.fromJson(Map<String, dynamic> json) => _$JusoFromJson(json);

  Map<String, dynamic> toJson() => _$JusoToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Juso) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      detBdNmList.hashCode ^
      engAddr.hashCode ^
      rn.hashCode ^
      emdNm.hashCode ^
      zipNo.hashCode ^
      roadAddrPart2.hashCode ^
      emdNo.hashCode ^
      sggNm.hashCode ^
      jibunAddr.hashCode ^
      siNm.hashCode ^
      roadAddrPart1.hashCode ^
      bdNm.hashCode ^
      admCd.hashCode ^
      udrtYn.hashCode ^
      lnbrMnnm.hashCode ^
      roadAddr.hashCode ^
      lnbrSlno.hashCode ^
      buldMnnm.hashCode ^
      bdKdcd.hashCode ^
      liNm.hashCode ^
      rnMgtSn.hashCode ^
      mtYn.hashCode ^
      bdMgtSn.hashCode ^
      buldSlno.hashCode;
}
