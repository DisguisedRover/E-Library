class Review {
  final int id;
  final int bookId;
  final String reviewer;
  final String comment;
  final int rating;

  Review(
      {required this.id,
      required this.bookId,
      required this.reviewer,
      required this.comment,
      required this.rating});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      bookId: json['book_id'],
      reviewer: json['reviewer'],
      comment: json['comment'],
      rating: json['rating'],
    );
  }
}
