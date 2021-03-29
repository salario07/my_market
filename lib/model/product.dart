import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/json_parser.dart';

class Product {
  final int id;
  final int categoryId;
  final int stock;
  final String name;
  final String categoryName;
  final num price;
  final String description;
  final List<String> images;

  Product(
      {this.id,
      this.categoryId,
      this.stock,
      this.name,
      this.categoryName,
      this.price,
      this.description,
      this.images});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json[Constants.id],
      categoryId: json[Constants.category_id],
      stock: json[Constants.stock],
      name: json[Constants.name],
      categoryName: json[Constants.category_name],
      price: (json[Constants.price]),
      description: json[Constants.description],
      images: JsonParser.parseStringList(json[Constants.images]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.id: id,
      Constants.category_id: categoryId,
      Constants.stock: stock,
      Constants.name: name,
      Constants.category_name: categoryName,
      Constants.price: price,
      Constants.description: description,
      Constants.images: images
    };
  }

  static Product getDefault(){
    return Product(
        id: 0,
        name: '',
        categoryId: 0,
        categoryName: '',
        description: '',
        images: [],
        price: 0,
        stock: 0);
  }
}
