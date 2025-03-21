class CouponModel {
  int? coId;
  String? coName;
  int? coCount;
  int? coDiscount;
  String? coExpiredate;

  CouponModel(
      {this.coId,
      this.coName,
      this.coCount,
      this.coDiscount,
      this.coExpiredate});

  CouponModel.fromJson(Map<String, dynamic> json) {
    coId = json['co_id'];
    coName = json['co_name'];
    coCount = json['co_count'];
    coDiscount = json['co_discount'];
    coExpiredate = json['co_expiredate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =<String, dynamic>{};
    data['co_name'] = coName;
    data['co_count'] =coCount;
    data['co_discount'] = coDiscount;
    data['co_expiredate'] = coExpiredate;
    return data;
  }
}