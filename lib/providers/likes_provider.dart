import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinary_products/models/product.dart';

class LikesNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() => [];

  void addToLikes(Product product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  void removeFromLikes(Product product) {
    state = state.where((item) => item != product).toList();
  }

  bool isLiked(Product product) {
    return state.contains(product);
  }
}

final likesNotifierProvider =
    NotifierProvider<LikesNotifier, List<Product>>(LikesNotifier.new);
