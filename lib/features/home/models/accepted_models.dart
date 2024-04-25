class AcceptedOrdersModel {
  AcceptedOrdersModel({
    required this.date,
    required this.time,
    required this.ticketId,
    required this.scheduledDate,
    required this.createdDate,
    required this.categoryId,
    required this.subcategoryId,
    required this.customerId,
    required this.id,
    required this.ticketNo,
    required this.ticketSmsCode,
    required this.Descriptions,
    required this.Priority,
    required this.CategoryId,
    required this.SubCategoryId,
    required this.CompanyId,
    required this.TechnicianId,
    required this.CustomerId,
    required this.AddressId,
    required this.SourceType,
    required this.Timestamp,
    required this.CreatedBy,
    required this.WorkStatus,
    required this.Status,
    required this.checklistUserTicketId,
    required this.invoiceId,
    required this.createdDateTime,
    required this.Id,
    required this.CategoryNameEn,
    required this.CategoryNameAr,
    required this.Code,
    required this.img,
    required this.color,
    required this.SubCategoryNameEn,
    required this.SubCategoryNameAr,
    required this.imgUrl,
    required this.SubCategoryParentID,
    required this.Fullname,
    required this.PhoneNo,
    required this.NameOfAddress,
    required this.Area,
    required this.Block,
    required this.Street,
    required this.Building,
    required this.Floor,
    required this.FlatsNo,
    required this.BuildingType,
    required this.Latitude,
    required this.Longitude,
    required this.day,
  });
  late final String date;
  late final String time;
  late final int ticketId;
  late final String scheduledDate;
  late final String createdDate;
  late final int categoryId;
  late final int subcategoryId;
  late final int customerId;
  late final int id;
  late final String ticketNo;
  late final String ticketSmsCode;
  late final String Descriptions;
  late final String Priority;
  late final int CategoryId;
  late final int SubCategoryId;
  late final int CompanyId;
  late final int TechnicianId;
  late final int CustomerId;
  late final int AddressId;
  late final String SourceType;
  late final String Timestamp;
  late final String CreatedBy;
  late final String WorkStatus;
  late final String Status;
  late final int checklistUserTicketId;
  late final int invoiceId;
  late final String createdDateTime;
  late final int Id;
  late final String CategoryNameEn;
  late final String CategoryNameAr;
  late final String Code;
  late final String img;
  late final String color;
  late final String SubCategoryNameEn;
  late final String SubCategoryNameAr;
  late final String imgUrl;
  late final int SubCategoryParentID;
  late final String Fullname;
  late final String PhoneNo;
  late final String NameOfAddress;
  late final String Area;
  late final String Block;
  late final String Street;
  late final String Building;
  late final String Floor;
  late final String FlatsNo;
  late final String BuildingType;
  late final double Latitude;
  late final double Longitude;
  late final String day;
  
  AcceptedOrdersModel.fromJson(Map<String, dynamic> json){
    date = json['date'];
    time = json['time'];
    ticketId = json['ticket_id'];
    scheduledDate = json['scheduled_date'];
    createdDate = json['created_date'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    customerId = json['customer_id'];
    id = json['id'];
    ticketNo = json['ticket_no'];
    ticketSmsCode = json['ticket_sms_code'];
    Descriptions = json['Descriptions'];
    Priority = json['Priority'];
    CategoryId = json['CategoryId'];
    SubCategoryId = json['SubCategoryId'];
    CompanyId = json['CompanyId'];
    TechnicianId = json['TechnicianId'];
    CustomerId = json['CustomerId'];
    AddressId = json['AddressId'];
    SourceType = json['SourceType'];
    Timestamp = json['Timestamp'];
    CreatedBy = json['CreatedBy'];
    WorkStatus = json['WorkStatus'];
    Status = json['Status'];
    checklistUserTicketId = json['checklist_user_ticketId'];
    invoiceId = json['invoiceId'];
    createdDateTime = json['created_dateTime'];
    Id = json['Id'];
    CategoryNameEn = json['CategoryNameEn'];
    CategoryNameAr = json['CategoryNameAr'];
    Code = json['Code'];
    img = json['img'];
    color = json['color'];
    SubCategoryNameEn = json['SubCategoryNameEn'];
    SubCategoryNameAr = json['SubCategoryNameAr'];
    imgUrl = json['img_url'];
    SubCategoryParentID = json['SubCategoryParentID'];
    Fullname = json['Fullname'];
    PhoneNo = json['PhoneNo'];
    NameOfAddress = json['NameOfAddress'];
    Area = json['Area'];
    Block = json['Block'];
    Street = json['Street'];
    Building = json['Building'];
    Floor = json['Floor'];
    FlatsNo = json['FlatsNo'];
    BuildingType = json['BuildingType'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['time'] = time;
    _data['ticket_id'] = ticketId;
    _data['scheduled_date'] = scheduledDate;
    _data['created_date'] = createdDate;
    _data['category_id'] = categoryId;
    _data['subcategory_id'] = subcategoryId;
    _data['customer_id'] = customerId;
    _data['id'] = id;
    _data['ticket_no'] = ticketNo;
    _data['ticket_sms_code'] = ticketSmsCode;
    _data['Descriptions'] = Descriptions;
    _data['Priority'] = Priority;
    _data['CategoryId'] = CategoryId;
    _data['SubCategoryId'] = SubCategoryId;
    _data['CompanyId'] = CompanyId;
    _data['TechnicianId'] = TechnicianId;
    _data['CustomerId'] = CustomerId;
    _data['AddressId'] = AddressId;
    _data['SourceType'] = SourceType;
    _data['Timestamp'] = Timestamp;
    _data['CreatedBy'] = CreatedBy;
    _data['WorkStatus'] = WorkStatus;
    _data['Status'] = Status;
    _data['checklist_user_ticketId'] = checklistUserTicketId;
    _data['invoiceId'] = invoiceId;
    _data['created_dateTime'] = createdDateTime;
    _data['Id'] = Id;
    _data['CategoryNameEn'] = CategoryNameEn;
    _data['CategoryNameAr'] = CategoryNameAr;
    _data['Code'] = Code;
    _data['img'] = img;
    _data['color'] = color;
    _data['SubCategoryNameEn'] = SubCategoryNameEn;
    _data['SubCategoryNameAr'] = SubCategoryNameAr;
    _data['img_url'] = imgUrl;
    _data['SubCategoryParentID'] = SubCategoryParentID;
    _data['Fullname'] = Fullname;
    _data['PhoneNo'] = PhoneNo;
    _data['NameOfAddress'] = NameOfAddress;
    _data['Area'] = Area;
    _data['Block'] = Block;
    _data['Street'] = Street;
    _data['Building'] = Building;
    _data['Floor'] = Floor;
    _data['FlatsNo'] = FlatsNo;
    _data['BuildingType'] = BuildingType;
    _data['Latitude'] = Latitude;
    _data['Longitude'] = Longitude;
    _data['day'] = day;
    return _data;
  }
}