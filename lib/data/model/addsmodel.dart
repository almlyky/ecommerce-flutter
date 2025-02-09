class AddsModel {
  int? id;
  String? image;
  String? url;
  String? dateAdds;
  String? expiredAdds;

  AddsModel({this.id, this.image, this.url, this.dateAdds, this.expiredAdds});

  AddsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
    dateAdds = json['date_adds'];
    expiredAdds = json['expired_adds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['url'] = this.url;
    data['date_adds'] = this.dateAdds;
    data['expired_adds'] = this.expiredAdds;
    return data;
  }
}