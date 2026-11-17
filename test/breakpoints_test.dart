import 'package:famous_gadget/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('aligns web app bar titles with the header logo', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1200, 700);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    late double titleSpacing;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            titleSpacing = webHeaderAlignedTitleSpacing(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(titleSpacing, 20);

    tester.view.physicalSize = const Size(1324, 700);
    await tester.pump();
    expect(titleSpacing, 22);

    tester.view.physicalSize = const Size(1365, 700);
    await tester.pump();
    expect(titleSpacing, 0);
  });
}
