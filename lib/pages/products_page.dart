import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_card/image_card.dart';
import 'package:zinary_products/pages/product_page.dart';
import 'package:zinary_products/providers/cart_provider.dart';
import 'package:zinary_products/providers/likes_provider.dart';
import 'package:zinary_products/providers/products_provider.dart';
import 'package:zinary_products/utils/dialogs_and_snackbars.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(fetchProductsProvider);
    final cartItems = ref.watch(cartNotifierProvider);
    final likes = ref.watch(likesNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: productsAsync.when(
            error: (err, stack) => Center(
                  child: RefreshIndicator(
                    onRefresh: () => ref.refresh(fetchProductsProvider.future),
                    child: const Text('Error loading data'),
                  ),
                ),
            loading: () => const CircularProgressIndicator(),
            data: (data) => RefreshIndicator(
                  onRefresh: () => ref.refresh(fetchProductsProvider.future),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                              builder: (context) =>
                                  ProductPage(product: data[index]),
                            );
                            Navigator.push(context, route);
                          },
                          child: TransparentImageCard(
                            imageProvider: NetworkImage(data[index].image),
                            contentPadding: EdgeInsets.all(8),
                            tags: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.green,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Text(
                                  data[index].price.toStringAsFixed(2),
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                            title: Text(
                              data[index].title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            description: Text(
                              data[index].description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(color: Colors.white),
                            ),
                            footer: Row(
                              children: [
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    if (!ref
                                        .read(cartNotifierProvider.notifier)
                                        .isInCart(data[index])) {
                                      ref
                                          .read(cartNotifierProvider.notifier)
                                          .addToCart(data[index]);
                                      showMessageSnackBar(context,
                                          "${data[index].title} added to cart");
                                    } else {
                                      ref
                                          .read(cartNotifierProvider.notifier)
                                          .removeFromCart(data[index]);
                                      showMessageSnackBar(context,
                                          "${data[index].title} removed to cart");
                                    }
                                  },
                                  icon: Icon(
                                    cartItems.contains(data[index])
                                        ? Icons.remove_shopping_cart_rounded
                                        : Icons.add_shopping_cart_outlined,
                                    color: cartItems.contains(data[index])
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (!ref
                                          .read(likesNotifierProvider.notifier)
                                          .isLiked(data[index])) {
                                        ref
                                            .read(
                                                likesNotifierProvider.notifier)
                                            .addToLikes(data[index]);
                                        showMessageSnackBar(context,
                                            "${data[index].title} liked");
                                      } else {
                                        ref
                                            .read(
                                                likesNotifierProvider.notifier)
                                            .removeFromLikes(data[index]);
                                        showMessageSnackBar(context,
                                            "${data[index].title} unliked");
                                      }
                                    },
                                    icon: Icon(
                                      likes.contains(data[index])
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: likes.contains(data[index])
                                          ? Colors.amber
                                          : Colors.white,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
      ),
    );
  }
}
