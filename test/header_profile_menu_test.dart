import 'package:famous_gadget/controllers/auth_controller.dart';
import 'package:famous_gadget/view/navigation/header_profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.put(AuthController());
    Get.find<AuthController>().completeDemoAuthentication();
  });

  tearDown(Get.reset);

  testWidgets('confirms before logging out from the profile menu', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(appBar: AppBar(actions: const [HeaderProfileMenu()])),
      ),
    );

    await tester.tap(find.byTooltip('Account menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    expect(find.text('Are you sure you want to logout?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(Get.find<AuthController>().isAuthenticated, isTrue);

    await tester.tap(find.byTooltip('Account menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Logout'),
      ).last,
    );
    await tester.pumpAndSettle();

    expect(Get.find<AuthController>().isAuthenticated, isFalse);
  });
}
