import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:runix_project/core/constants/firebase_constants.dart';
import 'package:runix_project/core/providers/firebase_providers.dart';
import 'package:runix_project/models/product_model.dart';

final productRepositoryProvider = Provider((ref) {
  return ProductRepository(firestore: ref.watch(firestoreProvider));
});

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<Product>> getProducts() {
    return _products.snapshots().map(
      (event) {
        List<Product> products = [];
        for (var doc in event.docs) {
          products.add(Product.fromMap(doc.data() as Map<String, dynamic>));
        }
        return products;
      },
    );
  }

  Stream<Product> getProductById(String productId) {
    return _products.doc(productId).snapshots().map(
          (event) => Product.fromMap(event.data() as Map<String, dynamic>),
        );
  }

  Stream<List<Product>> searchProduct(String query) {
    return _products
        .where(
          'productName',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),
        )
        .snapshots()
        .map(
      (event) {
        List<Product> products = [];
        for (var product in event.docs) {
          products.add(Product.fromMap(product.data() as Map<String, dynamic>));
        }
        return products;
      },
    );
  }

  Stream<List<Product>> getProductByCategory(String productCategory) {
    return _products
        .where('productCategory', isEqualTo: productCategory)
        .snapshots()
        .map(
      (event) {
        List<Product> products = [];
        for (var product in event.docs) {
          products.add(Product.fromMap(product.data() as Map<String, dynamic>));
        }
        return products;
      },
    );
  }

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productsCollection);
}
