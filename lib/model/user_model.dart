class User {
  final String number;
  final String username;
  final String password;

  const User(
      {required this.number, required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) => User(
      number: json['number'],
      username: json['username'],
      password: json['password']);

  Map<String, dynamic> toJson() =>
      {'number': number, 'username': username, 'password': password};
}
