import 'package:famous_gadget/view/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('uses the shared product grid and removes wishlist items', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: WishlistScreen()));
    await tester.pumpAndSettle();

    expect(find.text('My Wishlist (4)'), findsOneWidget);
    expect(
      find.text('Sony WH-1000XM5 Noise Cancelling Headphones'),
      findsOneWidget,
    );

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate =
        grid.gridDelegate as SliverGridDelegateWithMaxCrossAxisExtent;
    expect(delegate.mainAxisExtent, 250);

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle();

    expect(find.text('My Wishlist (3)'), findsOneWidget);
  });
}
