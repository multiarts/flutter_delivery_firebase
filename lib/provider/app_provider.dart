import 'package:flutter/material.dart';
import 'package:note_firebase/model/products.dart';
import 'package:note_firebase/service/product_service.dart';

class AppProvider with ChangeNotifier{
  List<Products> _getProducts = [];
  ProductService _productService = ProductService();

  AppProvider(){
    _getAllProducts();
  }

  // getter
  List<Products> get getProducts => _getProducts;

  // methods
  void _getAllProducts() async {
    _getProducts = await _productService.getProducts();
    notifyListeners();
  }
}