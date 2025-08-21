class CartProduct {
  final String pdtId;
  final String pdtTitle;
  final String pdtImage;
  final double pdtPrice;
  final int quantity;

  CartProduct({
    required this.pdtId,
    required this.pdtTitle,
    required this.pdtImage,
    required this.pdtPrice,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'pdtId': pdtId,
    'pdtTitle': pdtTitle,
    'pdtImage': pdtImage,
    'pdtPrice': pdtPrice,
    'quantity': quantity,
  };

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      pdtId: json['pdtId'],
      pdtTitle: json['pdtTitle'],
      pdtImage: json['pdtImage'],
      pdtPrice: (json['pdtPrice'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
}
