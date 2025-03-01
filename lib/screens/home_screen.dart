import 'package:assignment_2/providers/products_provider.dart';
import 'package:assignment_2/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final refProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: refProvider.isLoading
          ? CircularProgressIndicator() //skeleton here
          : Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: refProvider.categories.length,
                      itemBuilder: (context, i) {
                        return TextButton(
                            onPressed: () {},
                            child: Text(refProvider.categories[i]));
                      }),
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.6, crossAxisCount: 2),
                      itemCount: refProvider.products.length,
                      itemBuilder: (context, i) {
                        return MyCard(product: refProvider.products[i]);
                      }),
                )
              ],
            ),
    );
  }
}
