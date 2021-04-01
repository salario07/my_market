import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_title.dart';
import 'package:my_market/widget/ui/show_product.dart';

class ItemSearch extends StatelessWidget {

  final Product product;

  ItemSearch(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Get.to(()=>ShowProduct(product.id)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(product.images[0],width: 40,height: 40),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextContent(product.name),
                TextTitle(Helper.buildPriceText(product.price.toString()))
              ],
            )
          ],
        ),
      ),
    );
  }
}
