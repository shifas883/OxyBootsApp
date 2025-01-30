class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final bool isPromotional;
  final int? discount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isPromotional,
    this.discount,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      isPromotional: data['isPromotional'] ?? false,
      discount: data['discount'] != null ? data['discount'] as int : null,
    );
  }
}
