class Feeds {
  final List<dynamic> feeds;

  Feeds({this.feeds});

  factory Feeds.fromJson(Map<String, dynamic> json) {
    return Feeds(
      feeds: json['feedbacks'],
    );
  }
}