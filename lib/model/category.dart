import 'package:my_market/helper/constants.dart';

class Category {
  final int id;
  final String name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json[Constants.id], name: json[Constants.name]);
  }

  Map<String, dynamic> toJson() => {Constants.id: id, Constants.name: name};
}
