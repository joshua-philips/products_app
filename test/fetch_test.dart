import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zinary_products/providers/products_provider.dart';

import 'fetch_test.mocks.dart';

@GenerateMocks([Fetch])
void main() {
  group('Fetch', () {
    late MockFetch mockFetch;

    setUp(() {
      mockFetch = MockFetch();
    });

    test('fetchList returns a list of dynamic', () async {
      final List<dynamic> fetchList = [
        {
          'id': 1,
          'title': 'Product 1',
          'description': 'Description 1',
          'price': 10.0,
          'image': 'https://example.com/product1.jpg',
        },
      ];

      when(mockFetch.fetchList("https://fakestoreapi.com/products"))
          .thenAnswer((_) async => fetchList);

      final results =
          await mockFetch.fetchList("https://fakestoreapi.com/products");
      expect(results, isA<List<dynamic>>());
      expect(results.length, equals(1));
    });
  });
}
