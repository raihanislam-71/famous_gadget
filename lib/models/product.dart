class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.description,
    required this.specifications,
  });

  final String id;
  final String name;
  final double price;
  final double originalPrice;
  final String description;
  final Map<String, String> specifications;

  static const featured = Product(
    id: 'featured-headphones',
    name: 'Sony WH-1000XM5 Wireless Headphones',
    price: 32500,
    originalPrice: 45000,
    description: 'The Sony WH-1000XM5 delivers exceptional sound quality with clear highs, rich bass, and a balanced signature that stays natural across every genre. Whether you\'re commuting, working, or relaxing, the industry-leading noise cancellation helps you focus on the music while keeping background distractions at bay. Comfort is designed for long listening sessions. The headphones feel lightweight, and the soft ear cushions are shaped to fit comfortably around your ears without putting pressure on the sides of your head. With up to 30 hours of battery life and quick charging, you can enjoy uninterrupted listening all day.',
    specifications: {
      'Battery Life': 'Up to 30 Hours',
      'Noise Cancelling': 'Industry Leading ANC',
      'Driver Size': '30mm',
      'Connectivity': 'Bluetooth 5.2',
      'Weight': '250g',
      'Codec Support': 'LDAC / AAC / SBC',
      'Microphone': 'Beamforming (4 mics)',
      'Water Resistance': 'None',
    },
  );
}
