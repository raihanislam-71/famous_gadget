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
}
