class FeedbackRate {
  String id;
  String userId;
  String content;
  DateTime createdAt;
  int rating;

  FeedbackRate({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.rating,
  });
}
