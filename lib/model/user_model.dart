class User {
  final String emailOrNumber;
  final String username;
  final String password;

  User(
      {required this.emailOrNumber,
      required this.username,
      required this.password});

  factory User.fromMap(Map<String, dynamic> json) => User(
      emailOrNumber: json['emailOrNumber'],
      username: json['username'],
      password: json['password']);

  Map<String, dynamic> toJson() => {
        'emailOrNumber': emailOrNumber,
        'username': username,
        'password': password
      };
}