import 'package:flutter/material.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/model/product.dart';

class ItemProduct extends StatelessWidget {
  final Product product;
  final Function onTap;

  ItemProduct(this.product, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.card_border_radius)),
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImage(),
              SizedBox(height: 8),
              buildTitle(),
              SizedBox(height: 8),
              buildPrice()
            ],
          ),
        ),
      ),
    );
  }

  Text buildPrice() {
    return Text(
      Helper.buildPriceText(product?.price ?? 0),
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Text buildTitle() {
    return Text(
      Helper.isLocaleEnglish()
          ? product?.name ?? ''
          : product?.persianName ?? '',
      style: TextStyle(fontSize: 14),
    );
  }

  Center buildImage() {
    return Center(
      child: !Helper.isListNullOrEmpty(product.images)
          ? Image.network(
              product.images.elementAt(0),
              width: 80,
              height: 80,
            )
          : Icon(Icons.image, size: 80),
    );
  }
}
