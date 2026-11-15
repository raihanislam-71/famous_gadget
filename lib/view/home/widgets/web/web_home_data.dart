import '../../../../models/product.dart';
import '../../../utils/assets_path.dart';
import 'web_category_card.dart';

class WebHomeData {
  static const categories = [
    WebCategory('Smart Watch', '86', AssetsPath.smartWatch, 'Smart Watch'),
    WebCategory('Security Camera', '45', AssetsPath.camera, 'Security'),
    WebCategory('Gimbal', '32', AssetsPath.gimbal, 'Gimbal'),
    WebCategory('Accessories', '210', AssetsPath.phone, 'Accessories'),
    WebCategory('Projector', '28', AssetsPath.projector, 'Projector'),
    WebCategory('Microphone', '54', AssetsPath.gimbal, 'Microphone'),
    WebCategory('Router', '38', AssetsPath.projector, 'Router'),
    WebCategory('Tablets', '12', AssetsPath.phone, 'Tablet'),
  ];

  static const featured = [
    Product(
      id: 'anker-r50i',
      name: 'Anker Soundcore R50i True Wireless Earbuds',
      price: 1999,
      originalPrice: 2499,
      rating: '4.8',
      reviewCount: '210',
      imagePath: 'assets/images/figma_web/featured_earbuds.jpg',
    ),
    Product(
      id: 'haylou-watch',
      name: 'Haylou Solar Lite Smart Watch with SpO2',
      price: 2799,
      originalPrice: 3599,
      rating: '4.7',
      reviewCount: '89',
      imagePath: 'assets/images/figma_web/featured_watch.jpg',
    ),
    Product(
      id: 'dji-osmo',
      name: 'DJI Osmo Mobile 6 Smartphone Gimbal',
      price: 13499,
      originalPrice: 15000,
      rating: '4.9',
      reviewCount: '135',
      imagePath: 'assets/images/figma_web/featured_gimbal.jpg',
    ),
    Product(
      id: 'sony-xm5',
      name: 'Sony WH-1000XM5 Noise Cancelling Headphones',
      price: 32500,
      originalPrice: 45000,
      rating: '4.9',
      reviewCount: '342',
      imagePath: 'assets/images/figma_web/featured_headphones.jpg',
    ),
  ];

  static const bestSellers = [
    Product(
      id: 'oneplus-nord',
      name: 'OnePlus Nord CE 3 Lite 5G (8GB/256GB)',
      price: 24499,
      originalPrice: 27900,
      rating: '4.9',
      reviewCount: '340',
      imagePath: 'assets/images/figma_web/bestseller_phone.jpg',
    ),
    Product(
      id: 'a4tech-keyboard',
      name: 'A4Tech Bloody B820R Mechanical Keyboard',
      price: 4200,
      originalPrice: 5000,
      rating: '4.6',
      reviewCount: '120',
      imagePath: 'assets/images/figma_web/bestseller_keyboard.jpg',
    ),
    Product(
      id: 'xiaomi-tv-box',
      name: 'Xiaomi Mi TV Box S 2nd Gen 4K Ultra HD',
      price: 5699,
      originalPrice: 6500,
      rating: '4.8',
      reviewCount: '412',
      imagePath: 'assets/images/figma_web/bestseller_tvbox.jpg',
    ),
    Product(
      id: 'tp-link-router',
      name: 'TP-Link Archer C6 MU-MIMO Router',
      price: 2399,
      originalPrice: 2800,
      rating: '4.7',
      reviewCount: '512',
      imagePath: 'assets/images/figma_web/bestseller_router.jpg',
    ),
  ];

  static const newArrivals = [
    Product(
      id: 'xiaomi-pad',
      name: 'Xiaomi Pad 6 (8GB/256GB)',
      price: 36500,
      originalPrice: 39000,
      rating: '4.8',
      reviewCount: '45',
      imagePath: 'assets/images/figma_web/new_phone.jpg',
    ),
    Product(
      id: 'realme-buds',
      name: 'Realme Buds T300 with 30dB ANC',
      price: 2850,
      originalPrice: 3500,
      rating: '4.6',
      reviewCount: '28',
      imagePath: 'assets/images/figma_web/new_earbuds.jpg',
    ),
    Product(
      id: 'boya-mic',
      name: 'BoyaLink Wireless Dual Lavalier Microphone',
      price: 9499,
      originalPrice: 11000,
      rating: '4.7',
      reviewCount: '19',
      imagePath: 'assets/images/figma_web/new_lavalier.jpg',
    ),
    Product(
      id: 'wanbo-projector',
      name: 'Wanbo T2 Max Smart Full HD Projector',
      price: 16499,
      originalPrice: 18999,
      rating: '4.5',
      reviewCount: '67',
      imagePath: 'assets/images/figma_web/new_projector.jpg',
    ),
  ];

  static const recommended = [
    Product(
      id: 'logitech-webcam',
      name: 'Logitech C922 Pro Stream Webcam',
      price: 10500,
      originalPrice: 12500,
      rating: '4.8',
      reviewCount: '94',
      imagePath: 'assets/images/figma_web/recommended_webcam.jpg',
    ),
    Product(
      id: 'anker-powercore',
      name: 'Anker PowerCore 24K 140W Power Bank',
      price: 14200,
      originalPrice: 16500,
      rating: '4.9',
      reviewCount: '210',
      imagePath: 'assets/images/figma_web/recommended_powerbank.jpg',
    ),
    Product(
      id: 'samsung-tab',
      name: 'Samsung Galaxy Tab S9 FE',
      price: 49500,
      originalPrice: 55000,
      rating: '4.8',
      reviewCount: '120',
      imagePath: 'assets/images/figma_web/recommended_tablet.jpg',
    ),
    Product(
      id: 'aventho-headset',
      name: 'Aventho Wireless Headset',
      price: 15499,
      originalPrice: 19500,
      rating: '4.7',
      reviewCount: '34',
      imagePath: 'assets/images/figma_web/recommended_headset.jpg',
    ),
  ];
}
