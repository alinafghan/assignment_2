import 'dart:convert';

import 'package:assignment_2/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  bool isLoading = false;
  List<Products> products = [];
  List<String> categories = [];

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
    var allCategories = products.map((product) => product.category).toList();
    categories = allCategories.toSet().toList();
  }
}
