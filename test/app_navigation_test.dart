import 'package:famous_gadget/view/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

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
  });
}
