import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_firebase/model/products.dart';

class ProductService {
  Firestore _firestore = Firestore.instance;
  String collection = 'notes';

  Future<List<Products>> getCategories(String category) =>
  _firestore.collection(collection).where('categoria', isEqualTo: category).getDocuments().then((snapshot){
    List<Products> categories = [];
    snapshot.documents.map((snapshot) => categories.add(Products.fromMap(snapshot.data)));
    return categories;
  });
  
  Future<List<Products>> getProducts() =>
  _firestore.collection(collection).getDocuments().then((snap){
    List<Products> products = [];
    snap.documents.map((snapshot) => products.add(Products.fromMap(snapshot.data)));
    return products;
  });
  
}