import 'package:flutter/material.dart';
import 'package:note_firebase/model/categories.dart';
import 'package:note_firebase/model/products.dart';
import 'package:note_firebase/service/product_service.dart';

class AppProvider with ChangeNotifier{
  List<Products> _getProducts = [];
  ProductService _productService = ProductService();

  List<Categories> _getCategories = [];

  AppProvider(){
    _getAllProducts();
  }

  // getter
  List<Products> get getProducts => _getProducts;
  List<Categories> get getCategories => _getCategories;

  // methods
  void _getAllProducts() async {
    _getProducts = await _productService.getProducts();
    notifyListeners();
  }
}