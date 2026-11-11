import 'package:famous_gadget/controllers/product_cart_button_controller.dart';
import 'package:famous_gadget/controllers/review_controller.dart';
import 'package:famous_gadget/view/product_details/out_of_stock_product_details_screen.dart';
import 'package:famous_gadget/view/product_details/product_details_screen.dart';
import 'package:famous_gadget/view/navigation/app_routes.dart';
import 'package:famous_gadget/view/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.put(ProductCartButtonController());
    Get.put(ReviewController());
  });

  tearDown(Get.reset);

  testWidgets('shows complete in-stock details in desktop layout', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1365, 768);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const ProductDetailsScreen(productId: 'anker-r50i'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Anker Soundcore R50i True Wireless Earbuds'),
      findsOneWidget,
    );
    expect(find.text('Key Specifications'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Add to Cart · ৳1,999'), findsOneWidget);
    expect(find.text('Buy Now'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'shows full details and unavailable state for out-of-stock item',
    (tester) async {
      tester.view.physicalSize = const Size(1365, 768);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        GetMaterialApp(
          theme: AppTheme.dark,
          home: const ProductDetailsScreen(
            productId: 'sony-xm5',
            isInStock: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Sony WH-1000XM5 Noise Cancelling Headphones'),
        findsOneWidget,
      );
      expect(find.text('OUT OF STOCK'), findsOneWidget);
      expect(find.text('Key Specifications'), findsOneWidget);
      expect(find.text('Currently Out of Stock'), findsOneWidget);
      expect(find.text('Notify When Available'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('OutOfStockProductDetailsScreen renders dedicated out-of-stock state', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1365, 768);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const OutOfStockProductDetailsScreen(productId: 'sony-xm5'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Sony WH-1000XM5 Noise Cancelling Headphones'),
      findsOneWidget,
    );
    expect(find.text('OUT OF STOCK'), findsOneWidget);
    expect(find.text('Currently Out of Stock'), findsOneWidget);
    expect(find.text('Notify When Available'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('resolves numbered product-card IDs to catalog products', (
    tester,
  ) async {
    Get.reset();
    Get.put(ProductCartButtonController());
    Get.put(ReviewController());

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const ProductDetailsScreen(productId: '1'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Haylou Solar Lite Smart Watch with SpO2'),
      findsOneWidget,
    );
    expect(find.text('Featured Gadget'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens product details from a nested web route', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        initialRoute: '/products/details/1',
        getPages: AppRoutePages.pages,
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Haylou Solar Lite Smart Watch with SpO2'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens product details from singular web route /products/detail/:productId', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        initialRoute: '/products/detail/anker-r50i',
        getPages: AppRoutePages.pages,
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Anker Soundcore R50i True Wireless Earbuds'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens out of stock product from route /products/out-of-stock/:productId', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.dark,
        initialRoute: '/products/out-of-stock/sony-xm5',
        getPages: AppRoutePages.pages,
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Sony WH-1000XM5 Noise Cancelling Headphones'),
      findsOneWidget,
    );
    expect(find.text('OUT OF STOCK'), findsOneWidget);
    expect(find.text('Currently Out of Stock'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens all reviews from a nested web route', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        initialRoute: '/products/reviews/anker-r50i',
        getPages: AppRoutePages.pages,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('All Reviews'), findsOneWidget);
    expect(Get.find<ReviewController>().sortedReviews, hasLength(7));
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders mobile layout with AppBar and bottom bar on small screens', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const ProductDetailsScreen(productId: 'anker-r50i'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Product Details'), findsOneWidget);
    expect(
      find.text('Anker Soundcore R50i True Wireless Earbuds'),
      findsOneWidget,
    );
    expect(find.text('Key Specifications'), findsOneWidget);
    expect(find.text('Add to Cart · ৳1,999'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps product details visible without narrow desktop overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(910, 512);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const ProductDetailsScreen(productId: 'anker-r50i'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Anker Soundcore R50i True Wireless Earbuds'),
      findsOneWidget,
    );
    expect(find.text('Key Specifications'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('See All Reviews opens the screen with the full review list', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const ProductDetailsScreen(productId: 'anker-r50i'),
      ),
    );
    await tester.pumpAndSettle();

    final seeAllButton = tester.widget<OutlinedButton>(
      find.ancestor(
        of: find.text('See All Reviews'),
        matching: find.byType(OutlinedButton),
      ),
    );
    seeAllButton.onPressed!();
    await tester.pumpAndSettle();

    expect(find.text('All Reviews'), findsOneWidget);
    expect(find.text('7 Reviews'), findsOneWidget);
    expect(Get.find<ReviewController>().sortedReviews, hasLength(7));
    expect(tester.takeException(), isNull);
  });

  testWidgets('WebSiteHeader shows announcement & search on home, hides on inner pages', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Inner page frame: isHome is false
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        initialRoute: '/products/details/anker-r50i',
        getPages: AppRoutePages.pages,
      ),
    );
    await tester.pumpAndSettle();

    // Orange announcement bar should NOT be shown
    expect(
      find.text('Gadgets you love. Cash on Delivery BD.'),
      findsNothing,
    );
    // Menu links should NOT be shown
    expect(find.text('New Arrivals'), findsNothing);
    expect(find.text('Campaigns'), findsNothing);

    // Now test Home page: should show announcement & links
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        initialRoute: '/home',
        getPages: AppRoutePages.pages,
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Gadgets you love. Cash on Delivery BD.'),
      findsOneWidget,
    );
    expect(find.text('New Arrivals'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
