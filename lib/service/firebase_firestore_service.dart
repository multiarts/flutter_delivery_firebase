import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_firebase/model/products.dart';

final CollectionReference productsCollection = Firestore.instance.collection('notes');
final CollectionReference categoriesCollection = Firestore.instance.collection('category');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  Future<Products> createNote(
    title,
    description,
    likes,
    calorias,
    minutos,
    estrelas,
    imagem,
    valor,
    categoria,
  ) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(productsCollection.document());

      final Products note = Products(ds.documentID, title, description, likes, calorias, minutos, estrelas, imagem, valor, categoria);
      final Map<String, dynamic> data = note.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Products.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getNoteList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = productsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
  
    return snapshots;
  }

  Stream<QuerySnapshot> getCategories(){
    Stream<QuerySnapshot> snapshots = categoriesCollection.snapshots();
    return snapshots;
  }

  Stream<QuerySnapshot> getProductsList({int limit}) {
    Stream<QuerySnapshot> snapshots = productsCollection.snapshots();

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  getAll() {
    getProductsList().listen((snapshot){
      final List<Products> product = snapshot.documents.map((documentSnapshot) => Products.fromMap(documentSnapshot.data)).toList();
      return product;
    });    
  }
  
  Stream<QuerySnapshot> getByCategorie(String categoria) {
    Stream<QuerySnapshot> snapshots = categoriesCollection.where('categoria', isEqualTo: categoria).snapshots();

    return snapshots;
  }

  Future<dynamic> updateNote(Products note) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(productsCollection.document(note.id));

      await tx.update(ds.reference, note.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteNote(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(productsCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
