class TicketDetailsModel {
  TicketDetailsModel({
    required this.ticketId,
    required this.CustomerId,
    required this.WorkStatus,
    required this.SubCategoryId,
    required this.CompanyId,
    required this.TechnicianId,
    required this.Descriptions,
    required this.Priority,
    required this.ticketNo,
    required this.checklistUserTicketId,
    required this.invoiceId,
    required this.date,
    required this.time,
    required this.customerid,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.Timestamp,
    required this.Code,
    required this.SubCategoryNameEn,
    required this.SubCategoryNameAr,
    required this.CategoryId,
    required this.CategoryNameEn,
    required this.CategoryNameAr,
    required this.catImgUrl,
    required this.catColor,
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
    required this.addressId,
  });
  late final int ticketId;
  late final int CustomerId;
  late final String WorkStatus;
  late final int SubCategoryId;
  late final int CompanyId;
  late final int TechnicianId;
  late final String Descriptions;
  late final String Priority;
  late final String ticketNo;
  late final int checklistUserTicketId;
  late final int invoiceId;
  late final String date;
  late final String time;
  late final int customerid;
  late final String customerName;
  late final String customerEmail;
  late final String customerPhone;
  late final String Timestamp;
  late final String Code;
  late final String SubCategoryNameEn;
  late final String SubCategoryNameAr;
  late final int CategoryId;
  late final String CategoryNameEn;
  late final String CategoryNameAr;
  late final String catImgUrl;
  late final String catColor;
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
  late final int addressId;
  
  TicketDetailsModel.fromJson(Map<String, dynamic> json){
    ticketId = json['ticket_id'];
    CustomerId = json['CustomerId'];
    WorkStatus = json['WorkStatus'];
    SubCategoryId = json['SubCategoryId'];
    CompanyId = json['CompanyId'];
    TechnicianId = json['TechnicianId'];
    Descriptions = json['Descriptions'];
    Priority = json['Priority'];
    ticketNo = json['ticket_no'];
    checklistUserTicketId = json['checklist_user_ticketId'];
    invoiceId = json['invoiceId'];
    date = json['date'];
    time = json['time'];
    customerid = json['customerid'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    Timestamp = json['Timestamp'];
    Code = json['Code'];
    SubCategoryNameEn = json['SubCategoryNameEn'];
    SubCategoryNameAr = json['SubCategoryNameAr'];
    CategoryId = json['CategoryId'];
    CategoryNameEn = json['CategoryNameEn'];
    CategoryNameAr = json['CategoryNameAr'];
    catImgUrl = json['catImgUrl'];
    catColor = json['catColor'];
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
    addressId = json['address_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ticket_id'] = ticketId;
    _data['CustomerId'] = CustomerId;
    _data['WorkStatus'] = WorkStatus;
    _data['SubCategoryId'] = SubCategoryId;
    _data['CompanyId'] = CompanyId;
    _data['TechnicianId'] = TechnicianId;
    _data['Descriptions'] = Descriptions;
    _data['Priority'] = Priority;
    _data['ticket_no'] = ticketNo;
    _data['checklist_user_ticketId'] = checklistUserTicketId;
    _data['invoiceId'] = invoiceId;
    _data['date'] = date;
    _data['time'] = time;
    _data['customerid'] = customerid;
    _data['customer_name'] = customerName;
    _data['customer_email'] = customerEmail;
    _data['customer_phone'] = customerPhone;
    _data['Timestamp'] = Timestamp;
    _data['Code'] = Code;
    _data['SubCategoryNameEn'] = SubCategoryNameEn;
    _data['SubCategoryNameAr'] = SubCategoryNameAr;
    _data['CategoryId'] = CategoryId;
    _data['CategoryNameEn'] = CategoryNameEn;
    _data['CategoryNameAr'] = CategoryNameAr;
    _data['catImgUrl'] = catImgUrl;
    _data['catColor'] = catColor;
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
    _data['address_id'] = addressId;
    return _data;
  }
}