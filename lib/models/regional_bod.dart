class RegionalBOD {
  final String? imageURL;
  final String name;
  final String company;
  final String position;
  final String positionTranslate;
  final List<RegionalBOD  > subordinate;

  RegionalBOD({
    required this.name,
    required this.company,
    required this.position,
    required this.positionTranslate,
    required this.subordinate,
    this.imageURL,
  });
}