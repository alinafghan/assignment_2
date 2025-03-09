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
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuilt whole page');

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
        body:
            Consumer<ProductsProvider>(builder: (context, refProvider, child) {
          return refProvider.isLoading
              ? Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: refProvider.allCategories.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8),
                              child: FilterChip(
                                label: Text(refProvider.allCategories[i]),
                                selected: selectedCategory ==
                                    refProvider.allCategories[i],
                                onSelected: (bool value) {
                                  refProvider.filterProducts(selectedCategory);
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
                          itemCount: refProvider.filteredProducts.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Shimmer(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color.fromARGB(255, 218, 217, 217)!,
                                    Colors.grey[100]!,
                                    Colors.grey[300]!,
                                  ],
                                  stops: const [0.4, 0.5, 0.6],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 47, 46, 46),
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
                          itemCount: refProvider.allCategories.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: FilterChip(
                                label: Text(refProvider.allCategories[i]),
                                selected: selectedCategory ==
                                    refProvider.allCategories[i],
                                onSelected: (bool value) {
                                  selectedCategory =
                                      refProvider.allCategories[i];
                                  refProvider.filterProducts(selectedCategory);
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
                          itemCount: refProvider.filteredProducts.length,
                          itemBuilder: (context, i) {
                            return MyCard(
                                product: refProvider.filteredProducts[i]);
                          }),
                    ),
                  ],
                );
        }));
  }
}
