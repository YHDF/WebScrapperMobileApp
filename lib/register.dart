class Register {
  final dynamic name;
  final dynamic email;
  final dynamic token;

  Register({this.name, this.email, this.token});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      name: json['name'],
      email: json['email'],
      token: json['api_token'],
    );
  }
}