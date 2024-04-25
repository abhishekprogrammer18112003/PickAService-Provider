class InvoicePriceListModel {
  int? id;
  String? title;
  String? normalPrice;
  String? subscriptionPrice;
  int? isActive;
  String? status;
  String? dateTime;

  InvoicePriceListModel(
      {this.id,
      this.title,
      this.normalPrice,
      this.subscriptionPrice,
      this.isActive,
      this.status,
      this.dateTime});

  InvoicePriceListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    normalPrice = json['normal_price'];
    subscriptionPrice = json['subscription_price'];
    isActive = json['isActive'];
    status = json['status'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['normal_price'] = this.normalPrice;
    data['subscription_price'] = this.subscriptionPrice;
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['dateTime'] = this.dateTime;
    return data;
  }
}