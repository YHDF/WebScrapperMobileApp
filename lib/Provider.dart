class Provider{
  int id_provider;
  String name;
  Provider({this.id_provider,this.name});
  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id_provider: json['id_provider'],
      name: json['name'],
    );
  }
}