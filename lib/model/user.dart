import 'package:my_market/helper/constants.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String role;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.password,
      this.role});

  Map<String, dynamic> toJson() => {
        Constants.id: id,
        Constants.firstName: firstName,
        Constants.lastName: lastName,
        Constants.userName: userName,
        Constants.password: password,
        Constants.role: role
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json[Constants.id],
      firstName: json[Constants.firstName],
      lastName: json[Constants.lastName],
      userName: json[Constants.userName],
      password: json[Constants.password],
      role: json[Constants.role],
    );
  }
}
