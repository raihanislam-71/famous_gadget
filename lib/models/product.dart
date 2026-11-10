class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.description,
    required this.specifications,
    this.imagePath = 'assets/images/shoe.png',
    this.isInStock = true,
  });

  final String id;
  final String name;
  final double price;
  final double originalPrice;
  final String description;
  final Map<String, String> specifications;
  final String imagePath;
  final bool isInStock;

  static Product demoForId(String id, {bool isInStock = true}) {
    const productIds = [
      'anker-r50i',
      'haylou-watch',
      'dji-osmo',
      'sony-xm5',
      'oneplus-nord',
      'a4tech-keyboard',
      'xiaomi-tv-box',
      'tp-link-router',
      'xiaomi-pad',
      'realme-buds',
      'boya-mic',
      'wanbo-projector',
      'logitech-webcam',
      'anker-powercore',
      'samsung-tab',
      'aventho-headset',
    ];
    final catalog = <String, Product>{
      'anker-r50i': const Product(
        id: 'anker-r50i',
        name: 'Anker Soundcore R50i True Wireless Earbuds',
        price: 1999,
        originalPrice: 2499,
        description:
            'Enjoy rich sound and deep bass with Anker Soundcore R50i earbuds. '
            'The lightweight, comfortable fit and long battery life make them '
            'ideal for everyday listening and calls.',
        specifications: {
          'Battery Life': 'Up to 10 hours (30 hours with case)',
          'Connectivity': 'Bluetooth 5.3',
          'Water Resistance': 'IPX5',
          'Charging': 'USB-C',
        },
        imagePath: 'assets/images/figma_web/featured_earbuds.jpg',
      ),
      'haylou-watch': const Product(
        id: 'haylou-watch',
        name: 'Haylou Solar Lite Smart Watch with SpO2',
        price: 2799,
        originalPrice: 3599,
        description:
            'A lightweight smart watch with health tracking, multiple sport '
            'modes, and a bright display for everyday use.',
        specifications: {
          'Display': '1.38-inch touch display',
          'Battery Life': 'Up to 10 days',
          'Health': 'Heart rate and SpO2 monitoring',
          'Water Resistance': 'IP68',
        },
        imagePath: 'assets/images/figma_web/featured_watch.jpg',
      ),
      'dji-osmo': const Product(
        id: 'dji-osmo',
        name: 'DJI Osmo Mobile 6 Smartphone Gimbal',
        price: 13499,
        originalPrice: 15000,
        description:
            'Capture smooth mobile video with three-axis stabilization, '
            'intelligent tracking, and a compact foldable design.',
        specifications: {
          'Stabilization': '3-axis',
          'Compatibility': 'iOS and Android smartphones',
          'Features': 'ActiveTrack and quick launch',
          'Design': 'Foldable with built-in extension rod',
        },
        imagePath: 'assets/images/figma_web/featured_gimbal.jpg',
      ),
      'sony-xm5': const Product(
        id: 'sony-xm5',
        name: 'Sony WH-1000XM5 Noise Cancelling Headphones',
        price: 32500,
        originalPrice: 45000,
        description:
            'Experience immersive listening with adaptive noise cancelling, '
            'clear hands-free calls, and comfortable all-day wear.',
        specifications: {
          'Battery Life': 'Up to 30 hours',
          'Noise Cancelling': 'Adaptive active noise cancelling',
          'Connectivity': 'Bluetooth and multipoint',
          'Charging': 'USB-C fast charging',
        },
        imagePath: 'assets/images/figma_web/featured_headphones.jpg',
      ),
      'oneplus-nord': const Product(
        id: 'oneplus-nord',
        name: 'OnePlus Nord CE 3 Lite 5G (8GB/256GB)',
        price: 24499,
        originalPrice: 27900,
        description:
            'A fast, reliable 5G smartphone with a high-refresh-rate display, '
            'large battery, and versatile camera system.',
        specifications: {
          'Memory': '8GB RAM / 256GB storage',
          'Network': '5G',
          'Display': '120Hz display',
          'Charging': '67W SUPERVOOC',
        },
        imagePath: 'assets/images/figma_web/bestseller_phone.jpg',
      ),
      'a4tech-keyboard': const Product(
        id: 'a4tech-keyboard',
        name: 'A4Tech Bloody B820R Mechanical Keyboard',
        price: 4200,
        originalPrice: 5000,
        description:
            'A responsive mechanical gaming keyboard with durable switches '
            'and customizable backlighting.',
        specifications: {
          'Switches': 'Light Strike optical switches',
          'Layout': 'Full-size',
          'Connection': 'Wired USB',
          'Lighting': 'RGB backlight',
        },
        imagePath: 'assets/images/figma_web/bestseller_keyboard.jpg',
      ),
      'xiaomi-tv-box': const Product(
        id: 'xiaomi-tv-box',
        name: 'Xiaomi Mi TV Box S 2nd Gen 4K Ultra HD',
        price: 5699,
        originalPrice: 6500,
        description:
            'Stream entertainment in 4K with a compact Android TV media '
            'player and voice-enabled remote.',
        specifications: {
          'Resolution': '4K Ultra HD',
          'Operating System': 'Google TV',
          'Connectivity': 'Wi-Fi and Bluetooth',
          'Audio': 'Dolby Atmos and DTS-HD',
        },
        imagePath: 'assets/images/figma_web/bestseller_tvbox.jpg',
      ),
      'tp-link-router': const Product(
        id: 'tp-link-router',
        name: 'TP-Link Archer C6 MU-MIMO Router',
        price: 2399,
        originalPrice: 2800,
        description:
            'A dual-band Wi-Fi router designed for smooth streaming, gaming, '
            'and reliable coverage throughout your home.',
        specifications: {
          'Wi-Fi': 'Dual-band AC1200',
          'Ports': 'Gigabit Ethernet',
          'Antennas': 'Four external antennas',
          'Features': 'MU-MIMO and access point mode',
        },
        imagePath: 'assets/images/figma_web/bestseller_router.jpg',
      ),
      'xiaomi-pad': const Product(
        id: 'xiaomi-pad',
        name: 'Xiaomi Pad 6 (8GB/256GB)',
        price: 36500,
        originalPrice: 39000,
        description:
            'A versatile tablet with a vivid high-refresh-rate display and '
            'powerful performance for work and entertainment.',
        specifications: {
          'Memory': '8GB RAM / 256GB storage',
          'Display': '11-inch 144Hz display',
          'Audio': 'Quad speakers with Dolby Atmos',
          'Battery': '8840mAh',
        },
        imagePath: 'assets/images/figma_web/new_phone.jpg',
      ),
      'realme-buds': const Product(
        id: 'realme-buds',
        name: 'Realme Buds T300 with 30dB ANC',
        price: 2850,
        originalPrice: 3500,
        description:
            'Compact wireless earbuds with active noise cancellation, '
            'powerful bass, and a comfortable all-day fit.',
        specifications: {
          'Noise Cancelling': 'Up to 30dB ANC',
          'Battery Life': 'Up to 40 hours with case',
          'Connectivity': 'Bluetooth 5.3',
          'Charging': 'USB-C fast charging',
        },
        imagePath: 'assets/images/figma_web/new_earbuds.jpg',
      ),
      'boya-mic': const Product(
        id: 'boya-mic',
        name: 'BoyaLink Wireless Dual Lavalier Microphone',
        price: 9499,
        originalPrice: 11000,
        description:
            'A compact dual-channel wireless microphone system for clear '
            'recording, interviews, and mobile content creation.',
        specifications: {
          'Channels': 'Dual transmitter system',
          'Connection': '2.4GHz wireless',
          'Compatibility': 'Mobile devices and cameras',
          'Use': 'Clip-on lavalier microphones',
        },
        imagePath: 'assets/images/figma_web/new_lavalier.jpg',
      ),
      'wanbo-projector': const Product(
        id: 'wanbo-projector',
        name: 'Wanbo T2 Max Smart Full HD Projector',
        price: 16499,
        originalPrice: 18999,
        description:
            'Enjoy a large-screen viewing experience with Full HD resolution, '
            'built-in smart features, and automatic image correction.',
        specifications: {
          'Resolution': 'Full HD 1080p',
          'Brightness': '450 ANSI lumens',
          'Focus': 'Auto focus and keystone correction',
          'Audio': 'Built-in stereo speakers',
        },
        imagePath: 'assets/images/figma_web/new_projector.jpg',
      ),
      'logitech-webcam': const Product(
        id: 'logitech-webcam',
        name: 'Logitech C922 Pro Stream Webcam',
        price: 10500,
        originalPrice: 12500,
        description:
            'Stream and video call in crisp detail with autofocus, stereo '
            'audio, and flexible recording options.',
        specifications: {
          'Video': '1080p at 30fps',
          'Focus': 'Autofocus',
          'Audio': 'Dual stereo microphones',
          'Connection': 'USB-A',
        },
        imagePath: 'assets/images/figma_web/recommended_webcam.jpg',
      ),
      'anker-powercore': const Product(
        id: 'anker-powercore',
        name: 'Anker PowerCore 24K 140W Power Bank',
        price: 14200,
        originalPrice: 16500,
        description:
            'High-capacity portable charging with fast USB-C output for '
            'phones, tablets, and compatible laptops.',
        specifications: {
          'Capacity': '24,000mAh',
          'Output': 'Up to 140W USB-C',
          'Ports': 'USB-C and USB-A',
          'Display': 'Smart digital status display',
        },
        imagePath: 'assets/images/figma_web/recommended_powerbank.jpg',
      ),
      'samsung-tab': const Product(
        id: 'samsung-tab',
        name: 'Samsung Galaxy Tab S9 FE',
        price: 49500,
        originalPrice: 55000,
        description:
            'A capable tablet with a bright display, S Pen support, and '
            'water-resistant construction for everyday productivity.',
        specifications: {
          'Display': '10.9-inch LCD',
          'Memory': '8GB RAM / 256GB storage',
          'Accessories': 'S Pen included',
          'Resistance': 'IP68 water and dust resistance',
        },
        imagePath: 'assets/images/figma_web/recommended_tablet.jpg',
      ),
      'aventho-headset': const Product(
        id: 'aventho-headset',
        name: 'Aventho Wireless Headset',
        price: 15499,
        originalPrice: 19500,
        description:
            'A wireless over-ear headset with detailed sound, comfortable '
            'padding, and convenient everyday controls.',
        specifications: {
          'Connection': 'Bluetooth wireless',
          'Battery Life': 'Extended listening time',
          'Controls': 'On-device playback controls',
          'Fit': 'Padded over-ear design',
        },
        imagePath: 'assets/images/figma_web/recommended_headset.jpg',
      ),
    };
    final numericId = int.tryParse(id);
    final catalogId =
        numericId != null && numericId >= 0 && numericId < productIds.length
        ? productIds[numericId]
        : id;
    final product = catalog[catalogId] ??
        (isInStock ? catalog['anker-r50i']! : featured);
    return Product(
      id: product.id,
      name: product.name,
      price: product.price,
      originalPrice: product.originalPrice,
      description: product.description,
      specifications: product.specifications,
      imagePath: product.imagePath,
      isInStock: isInStock,
    );
  }

  static List<Product> get demoProducts {
    return [
      demoForId('anker-r50i', isInStock: true),
      demoForId('haylou-watch', isInStock: true),
      demoForId('dji-osmo', isInStock: true),
      demoForId('sony-xm5', isInStock: false),
      demoForId('oneplus-nord', isInStock: true),
      demoForId('a4tech-keyboard', isInStock: true),
      demoForId('xiaomi-tv-box', isInStock: true),
      demoForId('tp-link-router', isInStock: true),
    ];
  }

  static List<Product> getRelatedProducts(String currentId, {int count = 4}) {
    return demoProducts
        .where((p) => p.id != currentId)
        .take(count)
        .toList();
  }

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
    imagePath: 'assets/images/figma_web/featured_headphones.jpg',
    isInStock: false,
  );
}
