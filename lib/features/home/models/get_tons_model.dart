class GetTonsModel {
  int? id;
  String? subCategoryNameEn;
  String? subCategoryNameAr;

  GetTonsModel({this.id, this.subCategoryNameEn, this.subCategoryNameAr});

  GetTonsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    subCategoryNameEn = json['SubCategoryNameEn'];
    subCategoryNameAr = json['SubCategoryNameAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SubCategoryNameEn'] = this.subCategoryNameEn;
    data['SubCategoryNameAr'] = this.subCategoryNameAr;
    return data;
  }
}