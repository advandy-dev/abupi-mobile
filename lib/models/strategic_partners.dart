class StrategicPartners {
  final String imageURL;
  final String name;
  final String? address;
  final String? phone;
  final String? email;
  final String? website;
  final String? fax;
  final String? callCenter;

  StrategicPartners({
    required this.imageURL,
    required this.name,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.fax,
    this.callCenter,
  });
}

