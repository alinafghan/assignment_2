import 'dart:convert';

import 'package:assignment_2/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  bool isLoading = false;
  List<Products> products = [];
  List<Products> filteredProducts = [];
  List<String> categories = [];
  List<String> allCategories = [];

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      var url = 'https://fakestoreapi.com/products';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        products = data
            .map(
                (product) => Products.fromJson(product as Map<String, dynamic>))
            .toList();
        setCategories();
      }
    } catch (e) {
      throw Exception('Error while loading Products $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setCategories() {
    var productCategories =
        products.map((product) => product.category).toList();
    categories = productCategories.toSet().toList();
    allCategories = ['All', ...categories];
    filterProducts('All');
  }

  void filterProducts(String category) async {
    isLoading = true;
    notifyListeners();
    try {
      await Future.delayed(Duration(seconds: 1));
      filteredProducts = category == 'All'
          ? products
          : products.where((product) => product.category == category).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('coudlnt filter $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
