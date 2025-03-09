import 'package:flutter/material.dart';

class CategoryFilterProvider with ChangeNotifier {
  String _selectedCategory = 'All';

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
