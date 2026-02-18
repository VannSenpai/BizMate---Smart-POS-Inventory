import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  final Widget child;
  final String value;
  const CartBadge({super.key, required this.child, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsetsGeometry.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.red
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16
            ),
            child: Text(value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ],
    );
  }
}