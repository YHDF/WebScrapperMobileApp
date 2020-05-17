class Login {
  final dynamic name;
  final dynamic email;
  final dynamic token;

  Login({this.name, this.email, this.token});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      name: json['name'],
      email: json['email'],
      token: json['api_token'],
    );
  }
}