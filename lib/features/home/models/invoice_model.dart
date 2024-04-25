class InvoiceModel {
  InvoiceModel({
    required this.id,
    required this.title,
    required this.price,
    required this.priceId,
    required this.isAdvance,
  });
  late final int id;
  late final String title;
  late final String price;
  late final int priceId;
  late final int isAdvance;
  
  InvoiceModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    price = json['price'];
    priceId = json['priceId'];
    isAdvance = json['isAdvance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['price'] = price;
    _data['priceId'] = priceId;
    _data['isAdvance'] = isAdvance;
    return _data;
  }
}