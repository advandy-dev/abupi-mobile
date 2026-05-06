class JournalPost {
  final String name;
  final String email;
  final String phone;
  final String companyName;
  final String companyAddress;
  final String abstract;

  JournalPost({
    required this.name,
    required this.email,
    required this.phone,
    required this.companyName,
    required this.companyAddress,
    required this.abstract,
  });

  factory JournalPost.fromJson(Map<String, dynamic> json) {
    return JournalPost(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      companyName: json['companyName'],
      companyAddress: json['companyAddress'],
      abstract: json['abstract'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'companyName': companyName,
      'companyAddress': companyAddress,
      'abstract': abstract,
    };
  }
}