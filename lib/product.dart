class Product{
  String id_product;
  int group_id;
  String name;
  String image;
  int price;
  String link;
  int visit;
  int best;
  Product({this.id_product,this.group_id,this.name,this.image,this.price,this.link,this.visit,this.best});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id_product: json['id_product'],
      group_id: json['group_id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      link: json['link'],
      visit: json['visits'],
      best: json['best'],
    );
  }
}