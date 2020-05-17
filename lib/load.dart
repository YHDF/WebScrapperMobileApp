class Load {
  final List<dynamic> product_by_visits;
  final List<dynamic> best_product;
  final List<dynamic> product;
  final List<dynamic> group;
  final List<dynamic> category;
  final List<dynamic> provider;

  Load({this.product_by_visits,this.best_product,this.product,this.group,this.category,this.provider});

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      product_by_visits: json['products_by_visits'],
      best_product: json['products_by_best'],
      product: json['products_all'],
      group: json['groups_all'],
      category: json['categories_all'],
      provider: json['providers_all'],
    );
  }
}