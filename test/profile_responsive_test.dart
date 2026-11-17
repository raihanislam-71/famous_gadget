import 'package:famous_gadget/controllers/auth_controller.dart';
import 'package:famous_gadget/controllers/profile_controller.dart';
import 'package:famous_gadget/controllers/theme_controller.dart';
import 'package:famous_gadget/view/profile/profile_screen.dart';
import 'package:famous_gadget/view/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.put(ThemeController());
    Get.put(AuthController());
    Get.put(ProfileController());
  });

  tearDown(Get.reset);

  testWidgets('renders the compact profile design on mobile', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(theme: AppTheme.light, home: const ProfileScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Profile'), findsOneWidget);
    expect(
      find.text('Login to unlock seamless gadget shopping'),
      findsOneWidget,
    );
    expect(
      find.text('Manage your profile, orders, and account preferences.'),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps the profile usable at tablet width', (tester) async {
    tester.view.physicalSize = const Size(800, 1024);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(theme: AppTheme.light, home: const ProfileScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome, Guest'), findsOneWidget);
    expect(find.text('My Orders'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('switches to the web profile design on desktop', (tester) async {
    tester.view.physicalSize = const Size(1365, 768);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const ProfileScreen(showWebHeader: false),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Sign in to manage your orders, wishlist, and delivery details.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('Unlock your full gadget account experience.'),
      findsOneWidget,
    );
    expect(find.text('Login to unlock seamless gadget shopping'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders the signed-in web account layout', (tester) async {
    tester.view.physicalSize = const Size(1365, 768);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    Get.find<AuthController>().completeDemoAuthentication();

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const ProfileScreen(showWebHeader: false),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Account'), findsOneWidget);
    expect(
      find.text('Manage your profile, orders, and account preferences.'),
      findsOneWidget,
    );
    expect(find.text('Edit Profile'), findsWidgets);
    expect(find.text('Settings'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('changes profile design when the viewport is resized', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const ProfileScreen(showWebHeader: false),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Login to unlock seamless gadget shopping'),
      findsOneWidget,
    );

    tester.view.physicalSize = const Size(1365, 768);
    await tester.pumpAndSettle();

    expect(
      find.text('Unlock your full gadget account experience.'),
      findsOneWidget,
    );
    expect(find.text('Login to unlock seamless gadget shopping'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
