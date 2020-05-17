class Succes {
  final dynamic success;


  Succes({this.success});

  factory Succes.fromJson(Map<String, dynamic> json) {
    return Succes(
      success: json['success'],
    );
  }
}