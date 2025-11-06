// models/review_model.dart
class ReviewsModel {
  final String author;
  final String content;
  ReviewsModel({
    required this.author,
    required this.content,
  });
  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      author: json['author'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
