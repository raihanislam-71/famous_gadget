import 'package:famous_gadget/controllers/bottom_nav_controller.dart';
import 'package:famous_gadget/controllers/cart_controller.dart';
import 'package:famous_gadget/controllers/theme_controller.dart';
import 'package:famous_gadget/view/navigation/app_navigation.dart';
import 'package:famous_gadget/view/navigation/routes/catalog_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('pushes to a parameterized route by name', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: AppRoutes.splash,
        getPages: [
          GetPage(
            name: AppRoutes.splash,
            page: () => const Scaffold(body: Text('Splash')),
          ),
          GetPage(
            name: '${AppRoutes.products}/:categoryName',
            page: () => Scaffold(body: Text(Get.parameters['categoryName']!)),
          ),
          GetPage(
            name: AppRoutes.products,
            page: () => const Scaffold(body: Text('All products')),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    AppRoutes.toNamed<void>(
      route: AppRoutes.products,
      arguments: const {'categoryName': 'Headphones'},
    );
    await tester.pumpAndSettle();

    expect(find.text('Headphones'), findsOneWidget);
  });

  testWidgets('uses the base route when no path arguments are supplied', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: AppRoutes.splash,
        getPages: [
          GetPage(
            name: AppRoutes.splash,
            page: () => const Scaffold(body: Text('Splash')),
          ),
          GetPage(
            name: AppRoutes.products,
            page: () => const Scaffold(body: Text('All products')),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    AppRoutes.toNamed<void>(route: AppRoutes.products);
    await tester.pumpAndSettle();

    expect(find.text('All products'), findsOneWidget);
  });

  testWidgets('browser back from cart restores the previous home tab', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    Get.put(BottomNavController());
    Get.put(CartController());
    Get.put(ThemeController());

    final delegate = WebHistoryGetDelegate();
    final cartPage = CatalogRoutes.pages.firstWhere(
      (page) => page.name == AppRoutes.cart,
    );
    await tester.pumpWidget(
      GetMaterialApp.router(
        routeInformationParser: GetInformationParser(
          initialRoute: AppRoutes.home,
        ),
        routerDelegate: delegate,
        getPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => GetBuilder<BottomNavController>(
              builder: (controller) => Scaffold(
                body: Text(
                  controller.selectedIndex == 0 ? 'Home' : 'Wrong tab',
                ),
              ),
            ),
          ),
          cartPage,
        ],
      ),
    );
    await tester.pumpAndSettle();

    AppRoutes.toNamed<void>(route: AppRoutes.cart);
    await tester.pumpAndSettle();
    expect(Get.find<BottomNavController>().selectedIndex, 2);

    await delegate.setNewRoutePath(GetNavConfig.fromRoute(AppRoutes.home)!);
    expect(Get.find<BottomNavController>().selectedIndex, 0);
    await tester.pump();
    expect(find.text('My Cart (0 Items)'), findsNothing);
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(Get.find<BottomNavController>().selectedIndex, 0);
    expect(delegate.history.map((route) => route.locationString), [
      AppRoutes.home,
    ]);
  });

  testWidgets('handles browser back through dynamic routes to the start', (
    tester,
  ) async {
    final delegate = WebHistoryGetDelegate();
    await tester.pumpWidget(
      GetMaterialApp.router(
        routeInformationParser: GetInformationParser(
          initialRoute: AppRoutes.home,
        ),
        routerDelegate: delegate,
        getPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => const Scaffold(body: Text('Home')),
          ),
          GetPage(
            name: '${AppRoutes.subCategory}/:categoryName',
            page: () => Scaffold(
              body: Text(Get.parameters['categoryName'] ?? 'No category'),
            ),
          ),
          GetPage(
            name: '${AppRoutes.products}/:categoryName',
            page: () => Scaffold(
              body: Text(Get.parameters['categoryName'] ?? 'No products'),
            ),
          ),
          GetPage(
            name: '${AppRoutes.productDetails}/:productId',
            page: () => Scaffold(
              body: Text(Get.parameters['productId'] ?? 'No product'),
            ),
          ),
          GetPage(
            name: AppRoutes.login,
            page: () => const Scaffold(body: Text('Login')),
          ),
          GetPage(
            name: AppRoutes.register,
            page: () => const Scaffold(body: Text('Register')),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    AppRoutes.toNamed<void>(
      route: AppRoutes.subCategory,
      arguments: const {'categoryName': 'Smart Watch'},
    );
    await tester.pumpAndSettle();
    expect(find.text('Smart Watch'), findsOneWidget);

    AppRoutes.toNamed<void>(
      route: AppRoutes.products,
      arguments: const {'categoryName': 'Flagship Phones'},
    );
    await tester.pumpAndSettle();
    expect(find.text('Flagship Phones'), findsOneWidget);

    AppRoutes.toNamed<void>(
      route: AppRoutes.productDetails,
      arguments: const {'productId': 'anker-r50i'},
    );
    await tester.pumpAndSettle();
    expect(find.text('anker-r50i'), findsOneWidget);

    await delegate.setNewRoutePath(
      GetNavConfig.fromRoute('/products/Flagship%20Phones')!,
    );
    await tester.pumpAndSettle();
    expect(find.text('Flagship Phones'), findsOneWidget);

    await delegate.setNewRoutePath(
      GetNavConfig.fromRoute('/categories/subcategory/Smart%20Watch')!,
    );
    await tester.pumpAndSettle();
    expect(find.text('Smart Watch'), findsOneWidget);

    await delegate.setNewRoutePath(GetNavConfig.fromRoute(AppRoutes.home)!);
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);

    AppRoutes.toNamed<void>(route: AppRoutes.login);
    await tester.pumpAndSettle();
    AppRoutes.toNamed<void>(route: AppRoutes.register);
    await tester.pumpAndSettle();

    await AppRoutes.resetStackToNamed(route: AppRoutes.home);
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(delegate.history.map((route) => route.locationString), [
      AppRoutes.home,
    ]);

    AppRoutes.toNamed<void>(route: AppRoutes.login);
    await tester.pumpAndSettle();
    AppRoutes.toNamed<void>(route: AppRoutes.register);
    await tester.pumpAndSettle();

    AppRoutes.offAllNamed<void>(route: AppRoutes.home);
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(delegate.history.map((route) => route.locationString), [
      AppRoutes.home,
    ]);
  });
}
