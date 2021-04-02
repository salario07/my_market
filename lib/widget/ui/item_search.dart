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
      onTap: () => Get.to(() => ShowProduct(product.id)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: buildContent(),
      ),
    );
  }

  Row buildContent() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [buildImage(), SizedBox(width: 16), buildInfo()],
    );
  }

  Column buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextContent(
            Helper.isLocaleEnglish() ? product.name : product.persianName),
        TextTitle(Helper.buildPriceText(product.price))
      ],
    );
  }

  Widget buildImage() {
    return product.images.length > 0
        ? Image.network(product.images[0], width: 40, height: 40)
        : Icon(Icons.image, size: 40);
  }
}
