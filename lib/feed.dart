class Feed{
  final dynamic id_feedback;
  final dynamic id_user;
  final dynamic subject;
  final dynamic text;

  Feed ({this.id_feedback,this.id_user, this.subject,this.text});
  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id_feedback: json['id_feedback'],
      id_user: json['user_id'],
      subject: json['subject'],
      text: json['text'],
    );
  }
}