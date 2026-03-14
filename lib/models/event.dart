/// Model class representing an Event
class Event {
  final int id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String? imageUrl;
  final String? location;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.imageUrl,
    this.location,
  });

  /// Get formatted date string
  String get formattedDate {
    try {
      DateTime start = DateTime.parse(startDate);
      DateTime end = DateTime.parse(endDate);

      String dateFormat = '${start.year}/${start.month}/${start.day} ${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
      dateFormat += ' - ${end.year}/${end.month}/${end.day} ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
      if (start.year == end.year && start.month == end.month && start.day == end.day) {
        // Using string interpolation with padLeft to ensure two digits
        String startHour = "${start.hour}:${start.minute.toString().padLeft(2, '0')}";
        String endHour = "${end.hour}:${end.minute.toString().padLeft(2, '0')}";

        dateFormat = "${start.year}-${start.month}-${start.day} $startHour-$endHour";
      }
      return dateFormat;
    } catch (e) {
      return '$startDate - $endDate';
    }
  }
}
