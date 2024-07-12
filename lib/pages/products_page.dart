import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinary_products/providers/products_provider.dart';
import 'package:zinary_products/widgets/product_card.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(fetchProductsProvider);

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
                        child: ProductCard(
                          product: data[index],
                        ),
                      );
                    },
                  ),
                )),
      ),
    );
  }
}
