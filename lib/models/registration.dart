class Registration {
  String companyName;
  String companyAddress;
  String businessLocationAddress;
  String businessPermitType;
  String companyStatus;
  String picName;
  String picPosition;
  String picPhone;
  String picEmail;
  String membershipType;

  Registration({
    required this.companyName,
    required this.companyAddress,
    required this.businessLocationAddress,
    required this.businessPermitType,
    required this.companyStatus,
    required this.picName,
    required this.picPosition,
    required this.picPhone,
    required this.picEmail,
    required this.membershipType,
  });

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      companyName: json['companyName'],
      companyAddress: json['companyAddress'],
      businessLocationAddress: json['businessLocationAddress'],
      businessPermitType: json['businessPermitType'],
      companyStatus: json['companyStatus'],
      picName: json['picName'],
      picPosition: json['picPosition'],
      picPhone: json['picPhone'],
      picEmail: json['picEmail'],
      membershipType: json['membershipType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyAddress': companyAddress,
      'businessLocationAddress': businessLocationAddress,
      'businessPermitType': businessPermitType,
      'companyStatus': companyStatus,
      'picName': picName,
      'picPosition': picPosition,
      'picPhone': picPhone,
      'picEmail': picEmail,
      'membershipType': membershipType,
    };
  }
}