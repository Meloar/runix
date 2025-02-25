class Product {
  final String productName;
  final String productDescription;
  final String productPicture;
  final int productStock;
  final int productPrice;
  final String productSize;
  final String productCategory;
  final String productId;
  Product({
    required this.productName,
    required this.productDescription,
    required this.productPicture,
    required this.productStock,
    required this.productPrice,
    required this.productSize,
    required this.productCategory,
    required this.productId,
  });

  Product copyWith({
    String? productName,
    String? productDescription,
    String? productPicture,
    int? productStock,
    int? productPrice,
    String? productSize,
    String? productCategory,
    String? productId,
  }) {
    return Product(
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productPicture: productPicture ?? this.productPicture,
      productStock: productStock ?? this.productStock,
      productPrice: productPrice ?? this.productPrice,
      productSize: productSize ?? this.productSize,
      productCategory: productCategory ?? this.productCategory,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productDescription': productDescription,
      'productPicture': productPicture,
      'productStock': productStock,
      'productPrice': productPrice,
      'productSize': productSize,
      'productCategory': productCategory,
      'productId': productId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] as String,
      productDescription: map['productDescription'] as String,
      productPicture: map['productPicture'] as String,
      productStock: map['productStock'] as int,
      productPrice: map['productPrice'] as int,
      productSize: map['productSize'] as String,
      productCategory: map['productCategory'] as String,
      productId: map['productId'] as String,
    );
  }

  @override
  String toString() {
    return 'Product(productName: $productName, productDescription: $productDescription, productPicture: $productPicture, productStock: $productStock, productPrice: $productPrice, productSize: $productSize, productCategory: $productCategory, productId: $productId)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.productName == productName &&
        other.productDescription == productDescription &&
        other.productPicture == productPicture &&
        other.productStock == productStock &&
        other.productPrice == productPrice &&
        other.productSize == productSize &&
        other.productCategory == productCategory &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        productDescription.hashCode ^
        productPicture.hashCode ^
        productStock.hashCode ^
        productPrice.hashCode ^
        productSize.hashCode ^
        productCategory.hashCode ^
        productId.hashCode;
  }
}
