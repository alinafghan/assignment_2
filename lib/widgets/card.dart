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
          elevation: 8,
          margin: EdgeInsets.all(2),
          shadowColor: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Hero(
                  tag: product.image,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
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
                    padding: const EdgeInsets.only(
                        top: 6.0, bottom: 6.0, left: 6.0, right: 10),
                    child: RatingStars(
                      starSize: 14,
                      starColor: Colors.orangeAccent,
                      starOffColor: const Color.fromARGB(255, 111, 116, 117),
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
