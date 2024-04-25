class ProfileDataModel {
  ProfileDataModel({
    required this.userId,
    required this.FullName,
    required this.email,
    required this.isEmailVerified,
    required this.PhoneNo,
    required this.isPhoneVerified,
    required this.companyName,
    required this.CompanyId,
    required this.Pic,
  });
  late final int userId;
  late final String FullName;
  late final String email;
  late final String isEmailVerified;
  late final String PhoneNo;
  late final String isPhoneVerified;
  late final String companyName;
  late final int CompanyId;
  late final String Pic;
  
  ProfileDataModel.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    FullName = json['FullName'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    PhoneNo = json['PhoneNo'];
    isPhoneVerified = json['isPhoneVerified'];
    companyName = json['companyName'];
    CompanyId = json['CompanyId'];
    Pic = json['Pic'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['FullName'] = FullName;
    _data['email'] = email;
    _data['isEmailVerified'] = isEmailVerified;
    _data['PhoneNo'] = PhoneNo;
    _data['isPhoneVerified'] = isPhoneVerified;
    _data['companyName'] = companyName;
    _data['CompanyId'] = CompanyId;
    _data['Pic'] = Pic;
    return _data;
  }
}