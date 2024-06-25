import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:item_tracker/providers/item_provider.dart';
import 'package:item_tracker/screens/item_list_screen.dart';
import 'package:item_tracker/screens/item_edit_screen.dart';

void main() {
  testWidgets('Add item to the list', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ItemProvider(),
        child: const MaterialApp(
          home: ItemListScreen(),
        ),
      ),
    );

    // Verify the initial state is empty
    expect(find.byType(ListTile), findsNothing);

    // Tap the add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify navigation to the ItemEditScreen
    expect(find.byType(ItemEditScreen), findsOneWidget);

    // Fill the form and submit
    await tester.enterText(find.bySemanticsLabel('Name'), 'Test Item');
    await tester.enterText(find.bySemanticsLabel('Description'), 'Test Description');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Verify the item is added to the list
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('Edit item in the list', (WidgetTester tester) async {
    final itemProvider = ItemProvider();
    itemProvider.addItem('Original Item', 'Original Description');

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => itemProvider,
        child: const MaterialApp(
          home: ItemListScreen(),
        ),
      ),
    );

    // Verify the initial state has one item
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Original Item'), findsOneWidget);
    expect(find.text('Original Description'), findsOneWidget);

    // Tap the edit button
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Verify navigation to the ItemEditScreen
    expect(find.byType(ItemEditScreen), findsOneWidget);

    // Fill the form and submit
    await tester.enterText(find.bySemanticsLabel('Name'), 'Updated Item');
    await tester.enterText(find.bySemanticsLabel('Description'), 'Updated Description');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the item is updated in the list
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Updated Item'), findsOneWidget);
    expect(find.text('Updated Description'), findsOneWidget);
  });

  testWidgets('Remove item from the list', (WidgetTester tester) async {
    final itemProvider = ItemProvider();
    itemProvider.addItem('Test Item', 'Test Description');

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => itemProvider,
        child: const MaterialApp(
          home: ItemListScreen(),
        ),
      ),
    );

    // Verify the initial state has one item
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    // Tap the delete button
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Verify the item is removed from the list
    expect(find.byType(ListTile), findsNothing);
  });
}
