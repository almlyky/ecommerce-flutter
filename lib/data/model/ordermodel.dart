class OrderModel {
  int? id;
  String? status;
  String? paymentStatus;
  String? createdAt;
  String? address;
  int? totalOrder;
  String? orderCode;
  int? user;
  

  OrderModel(
      {this.id,
      this.status,
      this.paymentStatus,
      this.createdAt,
      this.address,
      this.totalOrder,
      this.orderCode,
      this.user});

  OrderModel.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    address = json['address'];
    totalOrder = json['total_order'];
    orderCode = json['order_code'];
    user = json['user'];
    DateTime dateTime = DateTime.parse(createdAt!);
        createdAt =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['status'] =status;
    data['payment_status'] = paymentStatus;
    data['created_at'] = createdAt;
    data['address'] = address;
    data['total_order'] = totalOrder;
    data['order_code'] = orderCode;
    data['user'] = user;
    return data;
  }
}