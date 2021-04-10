import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/shared_pref.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_title.dart';
import 'package:my_market/widget/ui/show_product.dart';
import 'package:my_market/widget/ui/show_product_admin.dart';

class ItemSearch extends StatelessWidget {
  final Product product;

  ItemSearch(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateToShowProduct,
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

  void navigateToShowProduct() {
    if (SharedPref.isUserAdmin()) {
      Get.to(() => ShowProductAdmin(product.id)).then((value) {
        if (value != null) {
          Helper.successSnackBar(LocaleKeys.shared_success.tr,
              LocaleKeys.show_product_product_deleted_successfully.tr);
        }
      });
    } else {
      Get.to(() => ShowProduct(product.id));
    }
  }
}
