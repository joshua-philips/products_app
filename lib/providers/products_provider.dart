import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinary_products/models/product.dart';

class Fetch {
  final Dio dio;
  Fetch({Dio? dio}) : dio = dio ?? Dio();

  Future<List<dynamic>> fetchList(String url) async {
    final Response response = await dio.get(url);
    return response.data;
  }
}

final fetchProvider = Provider<Fetch>((ref) {
  return Fetch();
});

final fetchProductsProvider =
    FutureProvider.autoDispose<List<Product>>((ref) async {
  List<Product> products = [];
  List<dynamic> results = await ref
      .read(fetchProvider)
      .fetchList("https://fakestoreapi.com/products");

  for (var element in results) {
    products.add(Product.fromJson(element));
  }
  ref.keepAlive();
  return products;
});
