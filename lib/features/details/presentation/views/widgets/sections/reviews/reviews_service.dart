// services/review_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/sections/reviews/reviews_model.dart';

class ReviewService {
  Future<List<ReviewsModel>> fetchReviews({
    required int id,
    required String contentType,
  }) async {
    final uri = Uri.parse(
      '$kbaseurl/$contentType/$id/reviews?api_key=$kapikey',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      return results.map((e) => ReviewsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }
}
