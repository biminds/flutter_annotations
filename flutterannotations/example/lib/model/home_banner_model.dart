//import 'package:json_annotation/json_annotation.dart';
//
//part 'home_banner_model.g.dart';
//
//@JsonSerializable()
//class HomeBannerModel  {
//
//  @JsonKey(name: 'desc')
//  String desc;
//
//  @JsonKey(name: 'id')
//  int id;
//
//  @JsonKey(name: 'imagePath')
//  String imagePath;
//
//  @JsonKey(name: 'isVisible')
//  int isVisible;
//
//  @JsonKey(name: 'order')
//  int order;
//
//  @JsonKey(name: 'title')
//  String title;
//
//  @JsonKey(name: 'type')
//  int type;
//
//  @JsonKey(name: 'url')
//  String url;
//
//  HomeBannerModel(this.desc,this.id,this.imagePath,this.isVisible,this.order,this.title,this.type,this.url,);
//
//  factory HomeBannerModel.fromJson(Map<String, dynamic> srcJson) => _$HomeBannerModelFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$HomeBannerModelToJson(this);
//
//}
//
//
//List<HomeBannerModel> getHomeBannerModelList(List<dynamic> list){
//  List<HomeBannerModel> result = [];
//  list.forEach((item){
//    result.add(HomeBannerModel.fromJson(item));
//  });
//  return result;
//}