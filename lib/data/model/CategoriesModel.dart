class CategoriesModel {
  int? catId;
  String? catName;
  String? catNameEn;
  String? catImage;

  CategoriesModel({this.catId, this.catName, this.catNameEn, this.catImage});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catNameEn = json['cat_name_en'];
    catImage = json['cat_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['cat_id'] = catId;
    data['cat_name'] = catName;
    data['cat_name_en'] = catNameEn;
    // data['cat_image'] = catImage;
    return data;
  }
}
