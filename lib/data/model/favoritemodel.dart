import 'package:eccommerce_new/data/model/ProductModel.dart';

class FavoriteModel {
  int? favNo;
  ProductModel? prFk;
  int? userFk;

  FavoriteModel({this.favNo, this.prFk, this.userFk});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    favNo = json['fav_no'];
    prFk = json['pr_fk'] != null ? ProductModel.fromJson(json['pr_fk']) : null;
    userFk = json['user_fk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fav_no'] = favNo;
    if (prFk != null) {
      data['pr_fk'] = prFk!.toJson();
    }
    data['user_fk'] = userFk;
    return data;
  }
}

class PrFk {
  int? prId;
  String? prName;
  String? prNameEn;
  String? prImage;
  int? prCost;
  String? prDetail;
  String? prDetailEn;
  int? catFk;

  PrFk(
      {this.prId,
      this.prName,
      this.prNameEn,
      this.prImage,
      this.prCost,
      this.prDetail,
      this.prDetailEn,
      this.catFk});

  PrFk.fromJson(Map<String, dynamic> json) {
    prId = json['pr_id'];
    prName = json['pr_name'];
    prNameEn = json['pr_name_en'];
    prImage = json['pr_image'];
    prCost = json['pr_cost'];
    prDetail = json['pr_detail'];
    prDetailEn = json['pr_detail_en'];
    catFk = json['cat_fk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pr_id'] = prId;
    data['pr_name'] = prName;
    data['pr_name_en'] = prNameEn;
    data['pr_image'] = prImage;
    data['pr_cost'] = prCost;
    data['pr_detail'] = prDetail;
    data['pr_detail_en'] = prDetailEn;
    data['cat_fk'] = catFk;
    return data;
  }
}