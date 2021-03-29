import 'package:flutter/material.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/model/category.dart';

class ItemCategory extends StatelessWidget {
  final Category? category;

  ItemCategory(this.category);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.card_border_radius)),
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Center(
          child: Text(
            category?.name??'',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
