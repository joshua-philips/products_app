import 'package:flutter/material.dart';

void showMessageSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    backgroundColor: Colors.black,
    content: Row(
      children: [
        Flexible(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            )
          ],
        )),
      ],
    ),
  ));
}
