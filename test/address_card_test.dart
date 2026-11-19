import 'package:famous_gadget/models/saved_address.dart';
import 'package:famous_gadget/view/profile/widgets/my_addresses/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('pins address edit action to the right edge', (tester) async {
    var wasEdited = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 600,
              child: AddressCard(
                address: const SavedAddress(
                  name: 'Arif Rahman',
                  phone: '01700000000',
                  streetAddress: 'House 24',
                  city: 'Dhaka',
                  postCode: '1230',
                  district: 'Uttara',
                ),
                onEdit: () => wasEdited = true,
              ),
            ),
          ),
        ),
      ),
    );

    final card = tester.getRect(find.byKey(const ValueKey('addressCard')));
    final editButton = tester.getRect(find.byTooltip('Edit address'));
    expect(editButton.center.dx, greaterThan(card.right - 40));

    await tester.tap(find.byTooltip('Edit address'));
    expect(wasEdited, isTrue);
  });
}
