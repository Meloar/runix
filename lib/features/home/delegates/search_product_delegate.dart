import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/core/common/error_text.dart';
import 'package:runix_project/core/common/loader.dart';
import 'package:runix_project/features/product/controller/product_controller.dart';

class SearchProductDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchProductDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchProductProvider(query)).when(
          data: (products) => ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.productName),
                onTap: () => navigateToProduct(context, product.productId),
              );
            },
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }

  void navigateToProduct(BuildContext context, String product) {
    Routemaster.of(context).pop();
    Routemaster.of(context).push('/product/$product');
  }
}
