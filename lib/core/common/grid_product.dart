import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:runix_project/models/product_model.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({super.key, required this.product});

  final Product product;

  void navigateToProduct(BuildContext context, Product product) {
    Routemaster.of(context).push('/product/${product.productId}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToProduct(context, product),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.productPicture,
                  width: double.infinity,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.productName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${product.productPrice.toString()} EUR',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
