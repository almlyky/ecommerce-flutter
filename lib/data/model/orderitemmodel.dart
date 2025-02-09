class OrderItemModel {
  int? id;
  Product? product;
  int? quantity;
  int? order;


  OrderItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    order = json['order'];
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
}