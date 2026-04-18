class ContactUs {
  final String email;
  final String firstName;
  final String lang;
  final String lastName;
  final String message;

  ContactUs({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.lang,
    required this.message,
  });

  factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
    email: json['email'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    lang: json['lang'],
    message: json['message'],
  );

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'lang': lang,
      'message': message,
    };
  }
}