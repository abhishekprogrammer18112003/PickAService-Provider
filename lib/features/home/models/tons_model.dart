class TonsModel {
  int? id;
  String? name;
  int? subCategoryId;
  String? status;
  String? dateTime;
  int? createdBy;

  TonsModel(
      {this.id,
      this.name,
      this.subCategoryId,
      this.status,
      this.dateTime,
      this.createdBy});

  TonsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subCategoryId = json['subCategoryId'];
    status = json['status'];
    dateTime = json['dateTime'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['subCategoryId'] = this.subCategoryId;
    data['status'] = this.status;
    data['dateTime'] = this.dateTime;
    data['createdBy'] = this.createdBy;
    return data;
  }
}