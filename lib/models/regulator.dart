class Regulator {
  final String imageURL;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String? fax;
  final String? callCenter;

  Regulator({
    required this.imageURL,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    this.fax,
    this.callCenter,
  });
}

