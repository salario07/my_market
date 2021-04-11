import 'package:my_market/helper/constants.dart';

class Product {
  int id;
  final int categoryId;
  int stock;
  final String name;
  final String persianName;
  final num price;
  final String description;
  String image;

  Product(
      {this.id,
      this.categoryId,
      this.stock,
      this.name,
      this.persianName,
      this.price,
      this.description,
      this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json[Constants.id],
      categoryId: json[Constants.category_id],
      stock: json[Constants.stock],
      name: json[Constants.name],
      persianName: json[Constants.persian_name],
      price: (json[Constants.price]),
      description: json[Constants.description],
      image: json[Constants.image],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.id: id,
      Constants.category_id: categoryId,
      Constants.stock: stock,
      Constants.name: name,
      Constants.persian_name: persianName,
      Constants.price: price,
      Constants.description: description,
      Constants.image: image
    };
  }

  static Product getDefault() {
    return Product(
        id: 0,
        name: '',
        categoryId: 0,
        persianName: '',
        description: '',
        image: '',
        price: 0,
        stock: 0);
  }
}
