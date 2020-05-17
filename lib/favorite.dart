class Favorite{
  int id_favorite;
  int id_user;
  String id_product;
  String name;
  String image;
  int price;
  String link;
  int available;
  Favorite({this.id_favorite,this.id_user,this.id_product,this.name,this.image,this.price,this.link,this.available});
  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id_favorite: json['id_favourite'],
      id_user: json['user_id'],
      id_product: json['product_id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      link: json['link'],
      available: json['available'],
    );
  }
}