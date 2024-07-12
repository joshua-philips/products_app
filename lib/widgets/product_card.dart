import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinary_products/models/product.dart';
import 'package:zinary_products/pages/product_page.dart';
import 'package:zinary_products/providers/cart_provider.dart';
import 'package:zinary_products/providers/likes_provider.dart';
import 'package:zinary_products/utils/dialogs_and_snackbars.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartNotifierProvider);
    final likes = ref.watch(likesNotifierProvider);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        child: Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
              color: Colors.black87,
              image: DecorationImage(
                image: NetworkImage(product.image),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade50,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    product.price.toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        if (!ref
                            .read(cartNotifierProvider.notifier)
                            .isInCart(product)) {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .addToCart(product);
                          showMessageSnackBar(
                              context, "${product.title} added to cart");
                        } else {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .removeFromCart(product);
                          showMessageSnackBar(
                              context, "${product.title} removed to cart");
                        }
                      },
                      icon: Icon(
                        cartItems.contains(product)
                            ? Icons.remove_shopping_cart_rounded
                            : Icons.add_shopping_cart_outlined,
                        color: cartItems.contains(product)
                            ? Colors.green
                            : Colors.white,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (!ref
                              .read(likesNotifierProvider.notifier)
                              .isLiked(product)) {
                            ref
                                .read(likesNotifierProvider.notifier)
                                .addToLikes(product);
                            showMessageSnackBar(
                                context, "${product.title} liked");
                          } else {
                            ref
                                .read(likesNotifierProvider.notifier)
                                .removeFromLikes(product);
                            showMessageSnackBar(
                                context, "${product.title} unliked");
                          }
                        },
                        icon: Icon(
                          likes.contains(product)
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: likes.contains(product)
                              ? Colors.amber
                              : Colors.white,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Route route = MaterialPageRoute(
            builder: (context) => ProductPage(
              product: product,
            ),
          );
          Navigator.push(context, route);
        },
      ),
    );
  }
}
