class Category{
  int id_category;
  String name;
  Category({this.id_category,this.name});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id_category: json['id_category'],
      name: json['name'],
    );
  }
}