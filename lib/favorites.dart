class Favourites {
  final List<dynamic> favourites;

  Favourites({this.favourites});

  factory Favourites.fromJson(Map<String, dynamic> json) {
    return Favourites(
      favourites: json['favourits'],
    );
  }
}