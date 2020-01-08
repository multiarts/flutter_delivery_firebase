import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_firebase/model/products.dart';
import 'package:note_firebase/ui/product_detail.dart';

class CategoriesList extends StatefulWidget {
  // final Products products;
  final String category;
  CategoriesList(this.category);
  _CategoriesListState createState() => _CategoriesListState(category);
}

class _CategoriesListState extends State<CategoriesList> {
  Products products;
  final String category;
  _CategoriesListState(this.category);

  List<Products> items;

  // FirebaseFirestoreService _service = FirebaseFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categoria: ${widget.category}"),
      ),
      body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('notes').where('categoria', isEqualTo: widget.category).snapshots(),
      // stream: _service.getByCategorie(widget.products.categoria),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
          items = snapshot.data.documents.map((doc)=> Products.fromMap(doc.data)).toList();
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index){
              return ListTile(
                leading: Image.network(items[index].imagem, fit: BoxFit.cover,),
                title: Text(items[index].title),
                subtitle: Text(items[index].categoria),
                onTap: () async {
                  Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (_) => ProductDetail(items[index])
                    )
                  );
                },
              );
            },
          );
        } else {
          return Text('Sei lá');
        }
      },
    )
    );
  }
}
