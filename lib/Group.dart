class Group{
  int id_group;
  int category_id;
  int provider_id;
  String name;
  Group({this.id_group,this.category_id,this.provider_id,this.name});
  
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id_group: json['id_group'],
      category_id: json['category_id'],
      provider_id: json['provider_id'],
      name: json['name'],
    );
  }
}