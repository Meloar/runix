import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/features/auth/controller/auth_controller.dart';
import 'package:runix_project/features/cart/controller/cart_controller.dart';
import 'package:runix_project/models/cart_product_model.dart';
import 'package:runix_project/models/product_model.dart';
import 'package:runix_project/models/user_model.dart';

class CartProduct extends ConsumerWidget {
  const CartProduct(
      {super.key, required this.product, required this.cartProduct});

  final Product product;
  final CartProductModel cartProduct;

  void navigateToProduct(BuildContext context, Product product) {
    Routemaster.of(context).push('/product/${product.productId}');
  }

  void decreaseProductCounterInCart(
      BuildContext context, WidgetRef ref, UserModel user) {
    ref.read(cartControllerProvider).updateProductCounterInCart(
        user: user,
        product: product,
        productCounter: cartProduct.productCounter - 1,
        context: context);
  }

  void increaseProductCounterInCart(
      BuildContext context, WidgetRef ref, UserModel user) {
    ref.read(cartControllerProvider).updateProductCounterInCart(
        user: user,
        product: product,
        productCounter: cartProduct.productCounter + 1,
        context: context);
  }

  void removeProductFromCart(
      BuildContext context, WidgetRef ref, UserModel user) {
    ref.read(cartControllerProvider).deleteProductFromCart(
        user: user,
        product: product,
        productCounter: cartProduct.productCounter,
        context: context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return GestureDetector(
      onTap: () => navigateToProduct(context, product),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.productPicture,
                  width: 120,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${product.productPrice * cartProduct.productCounter} EUR',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        cartProduct.productCounter > 1
                            ? IconButton(
                                onPressed: () => decreaseProductCounterInCart(
                                    context, ref, user),
                                icon: const Icon(
                                  Icons.remove,
                                ),
                              )
                            : IconButton(
                                onPressed: () =>
                                    removeProductFromCart(context, ref, user),
                                icon: const Icon(
                                  Icons.delete,
                                ),
                              ),
                        Text('${cartProduct.productCounter} db'),
                        IconButton(
                          onPressed: () =>
                              increaseProductCounterInCart(context, ref, user),
                          icon: const Icon(
                            Icons.add,
                          ),
                        ),
                        Spacer(),
                        cartProduct.productCounter > 1
                            ? IconButton(
                                onPressed: () =>
                                    removeProductFromCart(context, ref, user),
                                icon: const Icon(
                                  Icons.delete,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
