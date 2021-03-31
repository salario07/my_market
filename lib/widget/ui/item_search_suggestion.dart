import 'package:flutter/material.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/text_content.dart';

class ItemSearchSuggestion extends StatelessWidget {

  final Product _product;
  final Function onTap;

  ItemSearchSuggestion(this._product,this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
              child: TextContent(_product.name),
            )
          ],
        ),
        onTap: onTap
    );
  }
}
