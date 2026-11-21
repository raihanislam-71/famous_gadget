import 'package:famous_gadget/view/checkout/order_success_screen.dart';
import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('success screen follows light and dark themes', (tester) async {
    Future<void> pumpTheme(ThemeData theme) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const OrderSuccessScreen(isPreview: true),
        ),
      );
      await tester.pumpAndSettle();
    }

    await pumpTheme(AppTheme.light);
    _expectThemeColors(tester, AppTheme.light);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(tester.takeException(), isNull);

    await pumpTheme(AppTheme.dark);
    _expectThemeColors(tester, AppTheme.dark);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

void _expectThemeColors(WidgetTester tester, ThemeData theme) {
  final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
  expect(scaffold.backgroundColor, theme.scaffoldBackgroundColor);

  final title = tester.widget<Text>(find.text('Order Placed Successfully!'));
  expect(title.style?.color, theme.colorScheme.onSurface);

  final summary = tester.widget<Container>(
    find.byKey(const ValueKey('orderDetailsSummary')),
  );
  expect(
    (summary.decoration! as BoxDecoration).color,
    theme.colorScheme.surface,
  );
  expect(
    (summary.decoration! as BoxDecoration).color,
    isNot(AppColors.navyDark),
  );
}
