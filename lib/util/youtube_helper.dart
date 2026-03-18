import 'package:flutter/material.dart';

String? extractVideoId(String videoUrl) {
  try {
    Uri uri = Uri.parse(videoUrl);

    // 1. Handle youtu.be/VIDEO_ID
    if (uri.host == 'youtu.be') {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    // 2. Handle youtube.com variants
    if (uri.host.contains('youtube.com')) {
      // Standard: youtube.com/watch?v=VIDEO_ID
      if (uri.queryParameters.containsKey('v')) {
        return uri.queryParameters['v'];
      }
      // Embeds: youtube.com/embed/VIDEO_ID
      // Shorts: youtube.com/shorts/VIDEO_ID
      // Older: youtube.com/v/VIDEO_ID
      if (uri.pathSegments.isNotEmpty) {
        if (uri.pathSegments.contains('embed') ||
            uri.pathSegments.contains('shorts') ||
            uri.pathSegments.contains('v')) {
          return uri.pathSegments.last;
        }
      }
    }
  } catch (e) {
    debugPrint('Invalid URL: $e');
  }
  return null;
}