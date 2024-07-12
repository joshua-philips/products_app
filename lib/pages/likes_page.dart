import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinary_products/pages/product_page.dart';
import 'package:zinary_products/providers/likes_provider.dart';

class LikesPage extends ConsumerStatefulWidget {
  const LikesPage({super.key});

  @override
  ConsumerState<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends ConsumerState<LikesPage> {
  @override
  Widget build(BuildContext context) {
    final likes = ref.watch(likesNotifierProvider);
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
      child: likes.isEmpty
          ? const Center(
              child: Text("Got to the products page to start liking!"))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: likes.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: Key(index.toString()),
                      onDismissed: (direction) {
                        ref
                            .read(likesNotifierProvider.notifier)
                            .removeFromLikes(likes[index]);
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.heart_broken,
                                color: Colors.white,
                              ),
                              Text(
                                " Remove",
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(product: likes[index]));
                            Navigator.push(context, route);
                          },
                          leading: const CircleAvatar(
                            child: Icon(Icons.shopping_bag_outlined),
                          ),
                          title: Text(
                            likes[index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          subtitle: Text(likes[index].description,
                              overflow: TextOverflow.ellipsis, maxLines: 2),
                          trailing: Text(likes[index].price.toStringAsFixed(2)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
