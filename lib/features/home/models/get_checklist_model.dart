  class GetChecklistModel {
  GetChecklistModel({
    required this.id,
    required this.ticketId,
    required this.userId,
    required this.technicianId,
    required this.createdDate,
    required this.subCategoryId,
    required this.subcategorymodelId,
    required this.type,
    required this.imgUrl,
    required this.status,
    required this.name,
    required this.dateTime,
    required this.createdBy,
    required this.Id,
    required this.CategoryId,
    required this.SubCategoryNameEn,
    required this.SubCategoryNameAr,
    required this.Status,
    required this.SubCategoryParentID,
    required this.Timestamp,
    required this.CreatedBy,
    required this.modelName,
  });
  late final int id;
  late final int ticketId;
  late final int userId;
  late final int technicianId;
  late final String createdDate;
  late final int subCategoryId;
  late final int subcategorymodelId;
  late final String type;
  late final String imgUrl;
  late final String status;
  late final String name;
  late final String dateTime;
  late final int createdBy;
  late final int Id;
  late final int CategoryId;
  late final String SubCategoryNameEn;
  late final String SubCategoryNameAr;
  late final String Status;
  late final int SubCategoryParentID;
  late final String Timestamp;
  late final String CreatedBy;
  late final String modelName;
  
  GetChecklistModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    ticketId = json['ticketId'];
    userId = json['userId'];
    technicianId = json['technicianId'];
    createdDate = json['createdDate'];
    subCategoryId = json['sub_categoryId'];
    subcategorymodelId = json['subcategorymodelId'];
    type = json['type'];
    imgUrl = json['img_url'];
    status = json['status'];
    name = json['name'];
    dateTime = json['dateTime'];
    createdBy = json['createdBy'];
    Id = json['Id'];
    CategoryId = json['CategoryId'];
    SubCategoryNameEn = json['SubCategoryNameEn'];
    SubCategoryNameAr = json['SubCategoryNameAr'];
    Status = json['Status'];
    SubCategoryParentID = json['SubCategoryParentID'];
    Timestamp = json['Timestamp'];
    CreatedBy = json['CreatedBy'];
    modelName = json['modelName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['ticketId'] = ticketId;
    _data['userId'] = userId;
    _data['technicianId'] = technicianId;
    _data['createdDate'] = createdDate;
    _data['sub_categoryId'] = subCategoryId;
    _data['subcategorymodelId'] = subcategorymodelId;
    _data['type'] = type;
    _data['img_url'] = imgUrl;
    _data['status'] = status;
    _data['name'] = name;
    _data['dateTime'] = dateTime;
    _data['createdBy'] = createdBy;
    _data['Id'] = Id;
    _data['CategoryId'] = CategoryId;
    _data['SubCategoryNameEn'] = SubCategoryNameEn;
    _data['SubCategoryNameAr'] = SubCategoryNameAr;
    _data['Status'] = Status;
    _data['SubCategoryParentID'] = SubCategoryParentID;
    _data['Timestamp'] = Timestamp;
    _data['CreatedBy'] = CreatedBy;
    _data['modelName'] = modelName;
    return _data;
  }
}