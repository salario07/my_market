import 'package:flutter/material.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/model/product.dart';

class ItemProduct extends StatelessWidget {
  final Product product;

  ItemProduct(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.card_border_radius)),
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Image.network(
              product?.images[0],
              width: 80,
              height: 80,
            ),
            Text(
              product.name,
              style: TextStyle(fontSize: 14),
            ),
            Text(
              product.price.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
