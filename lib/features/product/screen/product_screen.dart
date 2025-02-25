import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/core/common/error_text.dart';
import 'package:runix_project/core/common/loader.dart';
import 'package:runix_project/features/auth/controller/auth_controller.dart';
import 'package:runix_project/features/cart/controller/cart_controller.dart';
import 'package:runix_project/features/product/controller/product_controller.dart';
import 'package:runix_project/models/product_model.dart';
import 'package:runix_project/models/user_model.dart';
import 'package:runix_project/theme/pallete.dart';

class ProductScreen extends ConsumerStatefulWidget {
  final String name;
  const ProductScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  void navigateToCart(BuildContext context) {
    Routemaster.of(context).push('/cart');
  }

  int _counter = 1;

  void increaseProductCounter() {
    _counter++;
  }

  void decreaseProductCounter() {
    if (_counter > 1) _counter--;
  }

  void addProductToCart(UserModel user, Product product, int productCounter) {
    ref.read(cartControllerProvider).addProductToCart(
        user: user,
        product: product,
        productCounter: productCounter,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Runix'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => navigateToCart(context),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: ref.watch(getProductProvider(widget.name)).when(
            data: (data) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    data.productPicture,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.productName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(data.productDescription),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text(
                                '${data.productPrice.toString()} EUR',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () => decreaseProductCounter(),
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text('$_counter db'),
                                    IconButton(
                                      onPressed: () => increaseProductCounter(),
                                      icon: const Icon(
                                        Icons.add,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text('Elérhető méret/ek: ${data.productSize}'),
                          const SizedBox(height: 10),
                          Text('Jelenleg raktáron van: ${data.productStock}'),
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: currentTheme.iconTheme.color,
                                foregroundColor:
                                    currentTheme.scaffoldBackgroundColor,
                              ),
                              onPressed: () =>
                                  addProductToCart(user, data, _counter),
                              child: Text('Kosárba rakom'),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => Loader(),
          ),
    );
  }
}
