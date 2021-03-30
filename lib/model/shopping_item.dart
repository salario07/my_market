import 'package:my_market/helper/constants.dart';

import 'product.dart';

class ShoppingItem {
  final Product product;
  int count;

  ShoppingItem({this.product, this.count});

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
        product: Product.fromJson(json[Constants.product]), count: json[Constants.count]);
  }

  Map<String, dynamic> toJson() =>
      {Constants.product: product.toJson(), Constants.count: count};
}
