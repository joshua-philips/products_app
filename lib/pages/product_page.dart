import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinary_products/models/product.dart';
import 'package:zinary_products/providers/cart_provider.dart';
import 'package:zinary_products/providers/likes_provider.dart';
import 'package:zinary_products/utils/dialogs_and_snackbars.dart';

class ProductPage extends ConsumerWidget {
  final Product product;
  const ProductPage({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartNotifierProvider);
    final likes = ref.watch(likesNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                if (!ref
                    .read(likesNotifierProvider.notifier)
                    .isLiked(product)) {
                  ref.read(likesNotifierProvider.notifier).addToLikes(product);
                  showMessageSnackBar(context, "${product.title} liked");
                } else {
                  ref
                      .read(likesNotifierProvider.notifier)
                      .removeFromLikes(product);
                  showMessageSnackBar(context, "${product.title} unliked");
                }
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Icon(
                  likes.contains(product)
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: likes.contains(product) ? Colors.amber : null,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                40,
              ),
              child: Image.network(
                product.image,
                alignment: Alignment.topCenter,
                scale: 2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  product.price.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (!ref
                    .read(cartNotifierProvider.notifier)
                    .isInCart(product)) {
                  ref.read(cartNotifierProvider.notifier).addToCart(product);
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
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: cartItems.contains(product)
                          ? Colors.green
                          : Colors.black),
                ),
                child: Icon(
                  cartItems.contains(product)
                      ? Icons.remove_shopping_cart
                      : Icons.add_shopping_cart_rounded,
                  color:
                      cartItems.contains(product) ? Colors.green : Colors.black,
                  size: 30,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Buy for ${product.price}'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
