import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:runix_project/core/constants/firebase_constants.dart';
import 'package:runix_project/core/failure.dart';
import 'package:runix_project/core/providers/firebase_providers.dart';
import 'package:runix_project/core/type_defs.dart';
import 'package:runix_project/models/cart_product_model.dart';
import 'package:runix_project/models/product_model.dart';
import 'package:runix_project/models/user_model.dart';

final cartRepositoryProvider = Provider(
  (ref) => CartRepository(firestore: ref.read(firestoreProvider)),
);

class CartRepository {
  final FirebaseFirestore _firestore;

  CartRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureVoid addProductToCart(
    UserModel user,
    Product product,
    int productCounter,
  ) async {
    try {
      for (var cartProduct in user.cart) {
        if (cartProduct['product']['productId'] == product.productId) {
          return left(Failure('Már a kosaradba van ez a termék!'));
        }
      }
      CartProductModel cartProduct = CartProductModel(
          product: product.toMap(),
          productCounter: productCounter,
          totalPrice: product.productPrice * productCounter);

      return right(_users.doc(user.uid).update({
        'cart': FieldValue.arrayUnion([cartProduct.toMap()])
      }));
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateProductCounterInCart(
      UserModel user, Product product, int productCounter) async {
    try {
      int index = 0;
      DocumentSnapshot userDoc = await _users.doc(user.uid).get();
      List<dynamic> cart = userDoc['cart'];
      for (int i = 0; i < cart.length; i++) {
        if (cart[i]['product']['productId'] == product.productId) {
          index = i;
        }
      }
      cart[index]['productCounter'] = productCounter;
      cart[index]['totalPrice'] = productCounter * product.productPrice;
      return right(_users.doc(user.uid).update({'cart': cart}));
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteProductFromCart(
    UserModel user,
    Product product,
    int productCounter,
  ) async {
    try {
      CartProductModel cartProduct = CartProductModel(
          product: product.toMap(),
          productCounter: productCounter,
          totalPrice: product.productPrice * productCounter);
      return right(_users.doc(user.uid).update({
        'cart': FieldValue.arrayRemove([cartProduct.toMap()])
      }));
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
}
