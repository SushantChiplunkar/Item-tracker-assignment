import 'package:flutter_test/flutter_test.dart';

import 'package:item_tracker/providers/item_provider.dart';

void main() {
  group('ItemProvider Tests', () {
    late ItemProvider itemProvider;

    setUp(() {
      itemProvider = ItemProvider();
    });

    test('Initial state is empty', () {
      expect(itemProvider.items, isEmpty);
    });

    test('Add item', () {
      itemProvider.addItem('Test Item', 'Test Description');
      expect(itemProvider.items.length, 1);
      expect(itemProvider.items[0].name, 'Test Item');
      expect(itemProvider.items[0].description, 'Test Description');
    });

    test('Edit item', () {
      itemProvider.addItem('Original Item', 'Original Description');
      itemProvider.editItem(0, 'Updated Item', 'Updated Description');
      expect(itemProvider.items[0].name, 'Updated Item');
      expect(itemProvider.items[0].description, 'Updated Description');
    });

    test('Remove item', () {
      itemProvider.addItem('Test Item', 'Test Description');
      itemProvider.removeItem(0);
      expect(itemProvider.items, isEmpty);
    });
  });
}
