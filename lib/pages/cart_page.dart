import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinary_products/pages/product_page.dart';
import 'package:zinary_products/providers/cart_provider.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartNotifierProvider);
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
      child: cartItems.isEmpty
          ? const Center(child: Text("Got to the products page to add items to cart"))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) => Dismissible(
                            key: Key(index.toString()),
                            onDismissed: (direction) {
                              ref
                                  .read(cartNotifierProvider.notifier)
                                  .removeFromCart(cartItems[index]);
                            },
                            background: Container(
                              color: Colors.red,
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      " Delete",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                onTap: () {
                                  Route route = MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          product: cartItems[index]));
                                  Navigator.push(context, route);
                                },
                                leading: const CircleAvatar(
                                  child: Icon(Icons.shopping_bag_outlined),
                                ),
                                title: Text(
                                  cartItems[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                subtitle: Text(cartItems[index].description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                                trailing: Text(
                                    cartItems[index].price.toStringAsFixed(2)),
                              ),
                            ),
                          )),
                  const Text(
                    "Amount",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    cartItems
                        .map((prod) => prod.price)
                        .reduce((value, item) => value + item)
                        .toStringAsFixed(2),
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
