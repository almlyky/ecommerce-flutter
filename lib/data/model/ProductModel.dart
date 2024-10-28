class ProductModel {
  int? prId;
  int? fav;
  String? prName;
  String? prNameEn;
  String? prImage;
  int? prCost;
  String? prDetail;
  String? prDetailEn;
  int? catFk;

  ProductModel(
      {this.prId,
      this.fav,
      this.prName,
      this.prNameEn,
      this.prImage,
      this.prCost,
      this.prDetail,
      this.prDetailEn,
      this.catFk});

  ProductModel.fromJson(Map<String, dynamic> json) {
    prId = json['pr_id'];
    fav = json['fav'];
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
    data['fav'] = fav;
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
