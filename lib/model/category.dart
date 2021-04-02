import 'package:my_market/helper/constants.dart';

class Category {
  final int id;
  final String name;
  final String persianName;

  Category({this.id, this.name, this.persianName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json[Constants.id],
        name: json[Constants.name],
        persianName: json[Constants.persian_name]);
  }

  Map<String, dynamic> toJson() => {
        Constants.id: id,
        Constants.name: name,
        Constants.persian_name: persianName
      };
}
