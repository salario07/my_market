import 'package:my_market/helper/constants.dart';

import 'product.dart';

class ShoppingItem {
  final int id;
  final Product product;
  int count;

  ShoppingItem({this.id, this.product, this.count});

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
        id: json[Constants.id],
        product: Product.fromJson(json[Constants.product]),
        count: json[Constants.count]);
  }

  Map<String, dynamic> toJson() => {
        Constants.id: id,
        Constants.product: product.toJson(),
        Constants.count: count
      };
}
