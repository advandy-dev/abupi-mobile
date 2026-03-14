class BoardOfDirector {
  final String? imageURL;
  final String name;
  final String position;
  final String positionTranslate;
  final String? section;
  final String? sectionTranslate;
  final List<Subordinate> subordinate;

  BoardOfDirector({
    required this.name,
    required this.position,
    required this.positionTranslate,
    required this.subordinate,
    this.section,
    this.sectionTranslate,
    this.imageURL,
  });
}

class Subordinate {
  final String? imageURL;
  final String position;
  final String positionTranslate;
  final String section;
  final String sectionTranslate;
  final String name;
  final String? company;

  Subordinate({
    required this.name,
    required this.position,
    required this.positionTranslate,
    required this.section,
    required this.sectionTranslate,
    this.imageURL,
    this.company,
  });
}