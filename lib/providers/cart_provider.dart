import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinary_products/models/product.dart';

class CartNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() => [];

  void addToCart(Product product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item != product).toList();
  }

  bool isInCart(Product product) {
    return state.contains(product);
  }
}

final cartNotifierProvider =
    NotifierProvider<CartNotifier, List<Product>>(CartNotifier.new);
