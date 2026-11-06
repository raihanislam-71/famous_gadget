class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.description,
    required this.specifications,
    this.isInStock = true,
  });

  final String id;
  final String name;
  final double price;
  final double originalPrice;
  final String description;
  final Map<String, String> specifications;
  final bool isInStock;

  static const featured = Product(
    id: 'featured-headphones',
    name: 'Sony WH-1000XM4 Noise Cancelling (OOS)',
    price: 28500,
    originalPrice: 34000,
    description: "The WH-1000XM4 delivers exceptional noise cancellation and smart listening technology that adjusts to your environment automatically.",
    specifications: {
      'Battery Life': 'Up to 30 Hours',
      'Noise Cancelling': 'Industry Leading ANC',
      'Driver Size': '40mm',
      'Connectivity': 'Bluetooth 5.0',
    },
    isInStock: false,
  );
}
