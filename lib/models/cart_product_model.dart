import 'package:flutter/foundation.dart';

class CartProductModel {
  final Map product;
  final int productCounter;
  final int totalPrice;
  CartProductModel({
    required this.product,
    required this.productCounter,
    required this.totalPrice,
  });

  CartProductModel copyWith({
    Map? product,
    int? productCounter,
    int? totalPrice,
  }) {
    return CartProductModel(
      product: product ?? this.product,
      productCounter: productCounter ?? this.productCounter,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product,
      'productCounter': productCounter,
      'totalPrice': totalPrice,
    };
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      product: Map.from((map['product'] as Map)),
      productCounter: map['productCounter'] as int,
      totalPrice: map['totalPrice'] as int,
    );
  }

  @override
  String toString() =>
      'CartProductModel(product: $product, productCounter: $productCounter, totalPrice: $totalPrice)';

  @override
  bool operator ==(covariant CartProductModel other) {
    if (identical(this, other)) return true;

    return mapEquals(other.product, product) &&
        other.productCounter == productCounter &&
        other.totalPrice == totalPrice;
  }

  @override
  int get hashCode =>
      product.hashCode ^ productCounter.hashCode ^ totalPrice.hashCode;
}
