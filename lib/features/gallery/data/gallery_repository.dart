import 'dart:convert';
import 'package:http/http.dart' as http;

import 'image_model.dart';

class GalleryRepository {
  static const String _baseUrl = 'https://picsum.photos/v2/list';

  Future<List<ImageModel>> fetchImages() async {
    final uri = Uri.parse(_baseUrl);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data
            .map((item) => ImageModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Server error. Please try again later.');
      }
    } catch (_) {
      throw Exception('Could not load images. Check your internet connection.');
    }
  }
}
