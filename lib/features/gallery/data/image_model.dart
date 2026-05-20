class ImageModel {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  const ImageModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id']?.toString() ?? '',
      author: json['author']?.toString() ?? 'Unknown Artist',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      url: json['url']?.toString() ?? '',
      downloadUrl: json['download_url']?.toString() ?? '',
    );
  }
}
