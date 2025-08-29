
// media.dart
enum MediaType { image, video }

class Media {
  final String url;
  final MediaType type;

  Media({required this.url, required this.type});
}
