import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> launchWebsite(String website) async {
  try {
    await launchUrlString(
      website,
      mode: LaunchMode.externalApplication, // Use the appropriate launch mode
    );
  } catch (e) {
    throw Exception('Could not launch $website $e');
  }
}

Future<void> launchEmail(List<String> emails) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: emails.join(','),
  );
  if (await canLaunchUrl(emailUri)) {
  await launchUrl(emailUri);
  }
}