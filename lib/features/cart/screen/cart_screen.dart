import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:runix_project/core/common/cart_product.dart';
import 'package:runix_project/core/common/error_text.dart';
import 'package:runix_project/core/common/loader.dart';
import 'package:runix_project/features/auth/controller/auth_controller.dart';
import 'package:runix_project/models/cart_product_model.dart';
import 'package:runix_project/models/product_model.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    int calculateTotalPrice() {
      int x = 0;
      for (var i = 0; i < user.cart.length; i++) {
        int alma = user.cart[i]['totalPrice'];
        x = x + alma;
      }
      return x;
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Runix'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                "Összesen: ${calculateTotalPrice()} EUR",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  minimumSize: Size(120, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Vásárlás',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          ref.watch(getUserDataProvider(user.uid)).when(
                data: (data) => Expanded(
                  child: ListView.builder(
                    itemCount: data.cart.length,
                    itemBuilder: (context, index) {
                      final cartProduct =
                          CartProductModel.fromMap(data.cart[index]);
                      final product = Product.fromMap(
                        data.cart[index]['product'],
                      );
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: CartProduct(
                          product: product,
                          cartProduct: cartProduct,
                        ),
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
