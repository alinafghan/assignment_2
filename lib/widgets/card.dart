import 'package:assignment_2/models/product_model.dart';
import 'package:assignment_2/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class MyCard extends StatelessWidget {
  final Products product;

  const MyCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductScreen(product: product);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
          margin: EdgeInsets.all(2),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Hero(
                  tag: product.image,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Image.network(
                      fit: BoxFit.cover,
                      product.image,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      '\$${product.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: RatingStars(
                      starSize: 14,
                      starColor: Colors.orangeAccent,
                      starOffColor: Colors.blueGrey,
                      value: product.rating.rate,
                      valueLabelVisibility: false,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
