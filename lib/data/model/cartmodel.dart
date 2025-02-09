class CartModel {
  int? cartId;
  PrFk? prFk;
  int? quantity;
  int? userFk;
  int? order;

  CartModel({this.cartId, this.prFk, this.quantity, this.userFk});

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    prFk = json['pr_fk'] != null ? PrFk.fromJson(json['pr_fk']) : null;
    quantity = json['quantity'];
    userFk = json['user_fk'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    if (prFk != null) {
      data['pr_fk'] = prFk!.toJson();
    }
    data['quantity'] = quantity;
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
