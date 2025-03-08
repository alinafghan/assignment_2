import 'package:assignment_2/providers/products_provider.dart';
import 'package:assignment_2/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All'; // Default category

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final refProvider = Provider.of<ProductsProvider>(context);

    List<String> categories = ['All', ...refProvider.categories];

    final filteredProducts = selectedCategory == 'All'
        ? refProvider.products
        : refProvider.products
            .where((product) => product.category == selectedCategory)
            .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: refProvider.isLoading
          ? Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          child: FilterChip(
                            label: Text(categories[i]),
                            selected: selectedCategory == categories[i],
                            onSelected: (bool value) {
                              setState(() {
                                selectedCategory = categories[i];
                              });
                            },
                          ),
                        );
                      }),
                ),
                // Product Grid
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.6, crossAxisCount: 2),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey[300]!, // Light gray
                                Colors.grey[100]!, // Almost white
                                Colors.grey[300]!, // Light gray
                              ],
                              stops: const [0.4, 0.5, 0.6], // Smooth transition
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ) // Skeleton loading
          : Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FilterChip(
                            label: Text(categories[i]),
                            selected: selectedCategory == categories[i],
                            onSelected: (bool value) {
                              setState(() {
                                selectedCategory = categories[i];
                              });
                            },
                          ),
                        );
                      }),
                ),
                // Product Grid
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.6, crossAxisCount: 2),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, i) {
                        return MyCard(product: filteredProducts[i]);
                      }),
                ),
              ],
            ),
    );
  }
}
