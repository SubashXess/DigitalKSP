class QuoteModels {
  final String id;
  final String quote;
  final String createdAt;

  const QuoteModels(
      {required this.id, required this.quote, required this.createdAt});

  factory QuoteModels.fromJson(Map<String, dynamic> json) {
    return QuoteModels(
      id: json['id'],
      quote: json['name'],
      createdAt: json['created_at'],
    );
  }

  static List<QuoteModels> quoteFromJson(Map<String, dynamic> jsonData) {
    final categories = jsonData['data']['quote'] as List;
    return categories.map((data) => QuoteModels.fromJson(data)).toList();
  }
}
