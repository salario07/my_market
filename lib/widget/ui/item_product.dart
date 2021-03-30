import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/ui/show_product.dart';

class ItemProduct extends StatelessWidget {
  final Product product;

  ItemProduct(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.card_border_radius)),
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Get.to(() => ShowProduct(product?.id??0)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product?.images?.elementAt(0)??'',
                  width: 80,
                  height: 80,
                ),
              ),
              Text(
                product?.name??'',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                product?.price.toString()??'',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
