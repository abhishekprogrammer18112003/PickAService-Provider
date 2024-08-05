class DeclineModel {
  DeclineModel({
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
    required this.ticketId,
    required this.technicianId,
    required this.customerId,
    required this.userType,
    required this.action,
    required this.ticketStatus,
    required this.createdDate,
    required this.createdBy,
    required this.customerName,
    required this.customerMail,
    required this.CategoryNameEn,
    required this.CategoryNameAr,
    required this.img,
    required this.categoryCode,
    required this.color,
    required this.SubCategoryNameEn,
    required this.SubCategoryNameAr,
    required this.subCategoryCode,
    required this.bookedDate,
    required this.bookedTime,
  });
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
  late final int ticketId;
  late final int technicianId;
  late final int customerId;
  late final String userType;
  late final String action;
  late final String ticketStatus;
  late final String createdDate;
  late final int createdBy;
  late final String customerName;
  late final String customerMail;
  late final String CategoryNameEn;
  late final String CategoryNameAr;
  late final String img;
  late final String categoryCode;
  late final String color;
  late final String SubCategoryNameEn;
  late final String SubCategoryNameAr;
  late final String subCategoryCode;
  late final String bookedDate;
  late final String bookedTime;
  
  DeclineModel.fromJson(Map<String, dynamic> json){
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
    ticketId = json['ticket_id'];
    technicianId = json['technician_id'];
    customerId = json['customer_id'];
    userType = json['user_type'];
    action = json['action'];
    ticketStatus = json['ticket_status'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    customerName = json['customer_name'];
    customerMail = json['customer_mail'];
    CategoryNameEn = json['CategoryNameEn'];
    CategoryNameAr = json['CategoryNameAr'];
    img = json['img'];
    categoryCode = json['categoryCode'];
    color = json['color'];
    SubCategoryNameEn = json['SubCategoryNameEn'];
    SubCategoryNameAr = json['SubCategoryNameAr'];
    subCategoryCode = json['subCategoryCode'];
    bookedDate = json['bookedDate'];
    bookedTime = json['bookedTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    _data['ticket_id'] = ticketId;
    _data['technician_id'] = technicianId;
    _data['customer_id'] = customerId;
    _data['user_type'] = userType;
    _data['action'] = action;
    _data['ticket_status'] = ticketStatus;
    _data['created_date'] = createdDate;
    _data['created_by'] = createdBy;
    _data['customer_name'] = customerName;
    _data['customer_mail'] = customerMail;
    _data['CategoryNameEn'] = CategoryNameEn;
    _data['CategoryNameAr'] = CategoryNameAr;
    _data['img'] = img;
    _data['categoryCode'] = categoryCode;
    _data['color'] = color;
    _data['SubCategoryNameEn'] = SubCategoryNameEn;
    _data['SubCategoryNameAr'] = SubCategoryNameAr;
    _data['subCategoryCode'] = subCategoryCode;
    _data['bookedDate'] = bookedDate;
    _data['bookedTime'] = bookedTime;
    return _data;
  }
}