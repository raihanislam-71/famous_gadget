import '../../../utils/assets_path.dart';
import 'web_category_card.dart';
import 'web_product_card.dart';

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
    WebProduct('Anker Soundcore R50i True Wireless Earbuds', 1999, 2499, '4.8', '210', 'featured_earbuds.jpg', 'anker-r50i'),
    WebProduct('Haylou Solar Lite Smart Watch with SpO2', 2799, 3599, '4.7', '89', 'featured_watch.jpg', 'haylou-watch'),
    WebProduct('DJI Osmo Mobile 6 Smartphone Gimbal', 13499, 15000, '4.9', '135', 'featured_gimbal.jpg', 'dji-osmo'),
    WebProduct('Sony WH-1000XM5 Noise Cancelling Headphones', 32500, 45000, '4.9', '342', 'featured_headphones.jpg', 'sony-xm5'),
  ];

  static const bestSellers = [
    WebProduct('OnePlus Nord CE 3 Lite 5G (8GB/256GB)', 24499, 27900, '4.9', '340', 'bestseller_phone.jpg', 'oneplus-nord'),
    WebProduct('A4Tech Bloody B820R Mechanical Keyboard', 4200, 5000, '4.6', '120', 'bestseller_keyboard.jpg', 'a4tech-keyboard'),
    WebProduct('Xiaomi Mi TV Box S 2nd Gen 4K Ultra HD', 5699, 6500, '4.8', '412', 'bestseller_tvbox.jpg', 'xiaomi-tv-box'),
    WebProduct('TP-Link Archer C6 MU-MIMO Router', 2399, 2800, '4.7', '512', 'bestseller_router.jpg', 'tp-link-router'),
  ];

  static const newArrivals = [
    WebProduct('Xiaomi Pad 6 (8GB/256GB)', 36500, 39000, '4.8', '45', 'new_phone.jpg', 'xiaomi-pad'),
    WebProduct('Realme Buds T300 with 30dB ANC', 2850, 3500, '4.6', '28', 'new_earbuds.jpg', 'realme-buds'),
    WebProduct('BoyaLink Wireless Dual Lavalier Microphone', 9499, 11000, '4.7', '19', 'new_lavalier.jpg', 'boya-mic'),
    WebProduct('Wanbo T2 Max Smart Full HD Projector', 16499, 18999, '4.5', '67', 'new_projector.jpg', 'wanbo-projector'),
  ];

  static const recommended = [
    WebProduct('Logitech C922 Pro Stream Webcam', 10500, 12500, '4.8', '94', 'recommended_webcam.jpg', 'logitech-webcam'),
    WebProduct('Anker PowerCore 24K 140W Power Bank', 14200, 16500, '4.9', '210', 'recommended_powerbank.jpg', 'anker-powercore'),
    WebProduct('Samsung Galaxy Tab S9 FE', 49500, 55000, '4.8', '120', 'recommended_tablet.jpg', 'samsung-tab'),
    WebProduct('Aventho Wireless Headset', 15499, 19500, '4.7', '34', 'recommended_headset.jpg', 'aventho-headset'),
  ];
}
