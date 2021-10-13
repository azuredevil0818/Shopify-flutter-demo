import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/app_colors.dart';
import 'package:shopify/core/app_routes.dart';
import 'package:shopify/data/model/collection_list.dart';
import 'package:shopify/utility/key_util.dart';
import 'package:shopify/view/common/product_item_view.dart';
import 'package:shopify/view/productDetails/product_details_model.dart';

class ProductYouMightLikeView extends ConsumerWidget {
  const ProductYouMightLikeView({required this.productType, Key? key})
      : super(key: key);

  final String productType;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final productsList = watch(productYouMightLikeProvider(productType));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "You Might Also Like",
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 273,
          child: productsList.when(
              data: (list) => ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        ProductItemView(products: list[index]),
                  ),
              loading: () => const CircularProgressIndicator(),
              error: (e, s) => const Text("error")),
        )
      ],
    );
  }
}
