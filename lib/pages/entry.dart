import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinary_products/pages/cart_page.dart';
import 'package:zinary_products/pages/likes_page.dart';
import 'package:zinary_products/pages/products_page.dart';
import 'package:zinary_products/providers/cart_provider.dart';
import 'package:zinary_products/providers/likes_provider.dart';

class Entry extends ConsumerStatefulWidget {
  const Entry({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntryState();
}

class _EntryState extends ConsumerState<Entry> {
  int _currentPage = 0;

  final List<Widget> _pages = [
    const ProductsPage(),
    const CartPage(),
    const LikesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartNotifierProvider);
    final likes = ref.watch(likesNotifierProvider);

    return Scaffold(
      body: SafeArea(
          child: IndexedStack(
        index: _currentPage,
        children: _pages,
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: cartItems.isNotEmpty,
              label: Text(cartItems.length.toString()),
              offset: const Offset(8, 8),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: likes.isNotEmpty,
              label: Text(likes.length.toString()),
              offset: const Offset(8, 8),
              child: const Icon(
                Icons.favorite_border,
              ),
            ),
            label: 'Likes',
          ),
        ],
      ),
    );
  }
}
