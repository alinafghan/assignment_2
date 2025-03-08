import 'package:assignment_2/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ProductScreen extends StatefulWidget {
  final Products product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Image.network(widget.product.image),
        Text(
          widget.product.title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          '\$${widget.product.price.toString()}',
          style: TextStyle(color: Colors.green),
        ),
        RatingStars(),
        Text(
          widget.product.description,
          textAlign: TextAlign.left,
        ),
      ]),
    );
  }
}
