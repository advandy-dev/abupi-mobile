class Consultation {
  final String name;
  final String role;
  final String companyName;
  final String companyAddress;
  final String email;
  final String phone;
  final String memberNo;
  final String subject;
  final String issue;
  final String? lang;

   Consultation({
      required this.name,
      required this.role,
      required this.companyName,
      required this.companyAddress,
      required this.email,
      required this.phone,
      required this.memberNo,
      required this.subject,
      required this.issue,
      this.lang,
   });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      name: json['name'],
      role: json['role'],
      companyName: json['companyName'],
      companyAddress: json['companyAddress'],
      email: json['email'],
      phone: json['phone'],
      memberNo: json['memberNo'],
      subject: json['subject'],
      issue: json['issue'],
      lang: json['lang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'companyName': companyName,
      'companyAddress': companyAddress,
      'email': email,
      'phone': phone,
      'memberNo': memberNo,
      'subject': subject,
      'issue': issue,
      'lang': lang,
    };
  }
}