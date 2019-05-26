import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';


@JsonSerializable()
class BannerModel extends Object {

  @JsonKey(name: 'banners')
  List<Banners> banners;

  @JsonKey(name: 'code')
  int code;

  BannerModel(this.banners,this.code,);

  factory BannerModel.fromJson(Map<String, dynamic> srcJson) => _$BannerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

}


@JsonSerializable()
class Banners extends Object {

  @JsonKey(name: 'imageUrl')
  String imageUrl;

  @JsonKey(name: 'targetId')
  int targetId;

  @JsonKey(name: 'targetType')
  int targetType;

  @JsonKey(name: 'titleColor')
  String titleColor;

  @JsonKey(name: 'typeTitle')
  String typeTitle;

  @JsonKey(name: 'exclusive')
  bool exclusive;

  @JsonKey(name: 'encodeId')
  String encodeId;

  @JsonKey(name: 'scm')
  String scm;

  Banners(this.imageUrl,this.targetId,this.targetType,this.titleColor,this.typeTitle,this.exclusive,this.encodeId,this.scm,);

  factory Banners.fromJson(Map<String, dynamic> srcJson) => _$BannersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannersToJson(this);

}


