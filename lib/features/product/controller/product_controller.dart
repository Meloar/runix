import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:runix_project/features/product/repository/product_repository.dart';
import 'package:runix_project/models/product_model.dart';

final productsProvider = StreamProvider((ref) {
  final productController = ref.watch(productControllerProvider);
  return productController.getProducts();
});

final productControllerProvider = Provider(
  (ref) {
    final productRepository = ref.watch(productRepositoryProvider);
    return ProductController(productRepository: productRepository);
  },
);

final getProductProvider = StreamProvider.family((ref, String productId) {
  return ref.watch(productControllerProvider).getProductById(productId);
});

final searchProductProvider = StreamProvider.family((ref, String query) {
  return ref.watch(productControllerProvider).searchProduct(query);
});

final getProductByCategoryProvider =
    StreamProvider.family((ref, String productCategory) {
  return ref
      .watch(productControllerProvider)
      .getProductByCategory(productCategory);
});

class ProductController {
  final ProductRepository _productRepository;
  ProductController({required ProductRepository productRepository})
      : _productRepository = productRepository;

  Stream<List<Product>> getProducts() {
    return _productRepository.getProducts();
  }

  Stream<Product> getProductById(String productId) {
    return _productRepository.getProductById(productId);
  }

  Stream<List<Product>> searchProduct(String query) {
    return _productRepository.searchProduct(query);
  }

  Stream<List<Product>> getProductByCategory(String productCategory) {
    return _productRepository.getProductByCategory(productCategory);
  }
}
