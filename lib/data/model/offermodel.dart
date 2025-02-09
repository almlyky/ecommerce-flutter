class OfferModel {
  int? id;
  Product? product;
  int? discountPercentage;
  String? startDate;
  String? endDate;

  OfferModel(
      {this.id,
      this.product,
      this.discountPercentage,
      this.startDate,
      this.endDate});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    discountPercentage = json['discount_percentage'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['discount_percentage'] = this.discountPercentage;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}

class Product {
  int? prId;
  String? prName;
  String? prNameEn;
  String? prImage;
  int? prCost;
  String? prDetail;
  String? prDetailEn;
  int? catFk;

  Product(
      {this.prId,
      this.prName,
      this.prNameEn,
      this.prImage,
      this.prCost,
      this.prDetail,
      this.prDetailEn,
      this.catFk});

  Product.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pr_id'] = this.prId;
    data['pr_name'] = this.prName;
    data['pr_name_en'] = this.prNameEn;
    data['pr_image'] = this.prImage;
    data['pr_cost'] = this.prCost;
    data['pr_detail'] = this.prDetail;
    data['pr_detail_en'] = this.prDetailEn;
    data['cat_fk'] = this.catFk;
    return data;
  }
}