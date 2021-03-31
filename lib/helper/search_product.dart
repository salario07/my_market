import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/ui/item_product.dart';
import 'package:my_market/widget/ui/item_search_suggestion.dart';
import 'package:my_market/widget/ui/show_product.dart';

class SearchProduct extends SearchDelegate {
  List<Product> allProducts;

  SearchProduct(this.allProducts);

  @override
  String get searchFieldLabel => LocaleKeys.home_page_search_product.tr;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => Get.back());
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> filtered = getFilteredList();
    return filtered.isNotEmpty
        ? buildSearchResult(filtered)
        : Center(
            child: TextContent(LocaleKeys.home_page_no_item_found.tr),
          );
  }

  GridView buildSearchResult(List<Product> filtered) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => ItemProduct(filtered[index]),
      scrollDirection: Axis.vertical,
      itemCount: filtered.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> filtered = getFilteredList();
    return filtered.isEmpty ? SizedBox() : buildSearchSuggestionList(filtered);
  }

  ListView buildSearchSuggestionList(List<Product> filtered) {
    return ListView.separated(
      itemBuilder: (context, index) => ItemSearchSuggestion(
          filtered[index], () => onSearchSuggestionTap(filtered[index].name)),
      scrollDirection: Axis.vertical,
      itemCount: filtered.length,
      padding: EdgeInsets.symmetric(vertical: 8),
      separatorBuilder: (context, index) => Divider(
        color: AppColors.colorDivider,
      ),
    );
  }

  void onSearchSuggestionTap(String name) {
    query = name;
    showResults(Get.context);
  }

  List<Product> getFilteredList() {
    if (query.isEmpty) {
      return allProducts;
    } else {
      List<Product> filtered = [];
      allProducts.forEach((element) {
        if (element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.description.toLowerCase().contains(query.toLowerCase())) {
          filtered.add(element);
        }
      });
      return filtered;
    }
  }
}
