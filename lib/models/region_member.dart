class RegionMember {
  final String region;
  final String regionTranslate;
  final int colorHex;
  final int? totalBUP;
  final int? totalTUKS;
  final int? totalTERSUS;

  RegionMember({
    required this.region,
    required this.regionTranslate,
    required this.colorHex,
    this.totalBUP,
    this.totalTUKS,
    this.totalTERSUS,
  });
}