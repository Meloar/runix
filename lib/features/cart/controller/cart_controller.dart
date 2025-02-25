import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:runix_project/core/utils.dart';
import 'package:runix_project/features/cart/repository/cart_repository.dart';
import 'package:runix_project/models/product_model.dart';
import 'package:runix_project/models/user_model.dart';

final cartControllerProvider = Provider(
  (ref) => CartController(cartRepository: ref.read(cartRepositoryProvider)),
);

class CartController {
  final CartRepository _cartRepository;
  CartController({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  void addProductToCart({
    required UserModel user,
    required Product product,
    required int productCounter,
    required BuildContext context,
  }) async {
    final res =
        await _cartRepository.addProductToCart(user, product, productCounter);

    res.fold(
      (l) {
        bool contain = false;
        for (var cartProduct in user.cart) {
          if (cartProduct['product']['productId'] == product.productId) {
            contain = true;
          }
        }
        if (contain) {
          showSnackBar(context, 'Már a kosaradban van ez a termék!');
        } else {
          showSnackBar(context, 'Sikertelen a kosárhoz adás');
        }
      },
      (r) => showSnackBar(context, 'Sikeresen hozzáadta a kosarához!'),
    );
  }

  void updateProductCounterInCart({
    required UserModel user,
    required Product product,
    required int productCounter,
    required BuildContext context,
  }) async {
    final res = await _cartRepository.updateProductCounterInCart(
      user,
      product,
      productCounter,
    );

    res.fold(
      (l) => null,
      (r) => null,
    );
  }

  void deleteProductFromCart({
    required UserModel user,
    required Product product,
    required int productCounter,
    required BuildContext context,
  }) async {
    final res = await _cartRepository.deleteProductFromCart(
        user, product, productCounter);

    res.fold(
      (l) => showSnackBar(context, 'Sikertelen az eltávolítás!'),
      (r) => showSnackBar(
          context, 'Sikeresen eltávolítottad a terméket a kosaradból!'),
    );
  }
}
