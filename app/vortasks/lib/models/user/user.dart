class User {
  final String id;
  final String name;
  final String username;
  final String email;
  //final String password;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    //required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userId'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      //password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': name,
      'username': username,
      'email': email,
      //'password': password,
    };
  }
}
