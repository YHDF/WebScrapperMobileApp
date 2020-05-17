import 'package:pfe_mobile/user.dart';

class Profile{
  dynamic user;
  int favorite_count;
  int feedback_count;
  Profile({this.user,this.favorite_count,this.feedback_count});
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      user: json['User'],
      favorite_count: json['Favs'],
      feedback_count: json['Feeds'],
    );
  }
}