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
      body: SingleChildScrollView(
        child: Column(children: [
          Hero(
            tag: widget.product.image,
            child: Image.network(
              widget.product.image,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\$${widget.product.price.toString()}',
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RatingStars(
                      valueLabelVisibility: false,
                      value: widget.product.rating.rate,
                      starColor: Colors.orangeAccent,
                      starOffColor: const Color.fromARGB(255, 111, 116, 117),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child:
                          Text('(${widget.product.rating.count.toString()})'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.product.description,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
