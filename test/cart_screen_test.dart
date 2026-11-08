import 'package:bdcalling_class/controllers/bottom_nav_controller.dart';
import 'package:bdcalling_class/controllers/cart_controller.dart';
import 'package:bdcalling_class/view/cart/cart_screen.dart';
import 'package:bdcalling_class/view/navigation/main_bottom_nav_screen.dart';
import 'package:bdcalling_class/view/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('renders the empty-cart design', (tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    Get.put(CartController());
    addTearDown(Get.reset);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const CartScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Cart (0 Items)'), findsOneWidget);
    expect(find.text('Your Cart is Empty'), findsOneWidget);
    expect(find.text('Start Shopping'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders the empty cart within the bottom navigation shell', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    Get.put(BottomNavController()..changeIndex(2));
    Get.put(CartController());
    addTearDown(Get.reset);

    await tester.pumpWidget(
      GetMaterialApp(theme: AppTheme.light, home: const MainBottomNavScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Cart (0 Items)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Start Shopping selects the home tab', (tester) async {
    Get.put(BottomNavController()..changeIndex(2));
    Get.put(CartController());
    addTearDown(Get.reset);

    await tester.pumpWidget(
      GetMaterialApp(theme: AppTheme.light, home: const CartScreen()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start Shopping'));

    expect(Get.find<BottomNavController>().selectedIndex, 0);
    expect(tester.takeException(), isNull);
  });
}
