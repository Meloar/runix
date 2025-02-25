import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String address;
  final List<Map<String, dynamic>> cart;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.address,
    required this.cart,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? address,
    List<Map<String, dynamic>>? cart,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      address: address ?? this.address,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'address': address,
      'cart': cart,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      cart: List<Map<String, dynamic>>.from(
        (map['cart'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x as Map<String, dynamic>,
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, address: $address, cart: $cart)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.address == address &&
        listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        address.hashCode ^
        cart.hashCode;
  }
}
