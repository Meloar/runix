import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/core/common/drawer.dart';
import 'package:runix_project/core/common/error_text.dart';
import 'package:runix_project/core/common/grid_product.dart';
import 'package:runix_project/core/common/loader.dart';
import 'package:runix_project/features/home/delegates/search_product_delegate.dart';
import 'package:runix_project/features/product/controller/product_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void navigateToCart(BuildContext context) {
    Routemaster.of(context).push('/cart');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Runix'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchProductDelegate(ref));
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => navigateToCart(context),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          ref.watch(productsProvider).when(
                data: (products) => Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: GridProduct(product: products[index]),
                      );
                    },
                  ),
                ),
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => Loader(),
              )
        ],
      ),
    );
  }
}
