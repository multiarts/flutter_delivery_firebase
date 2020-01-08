import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/model/products.dart';
import 'package:note_firebase/service/firebase_firestore_service.dart';
import 'package:note_firebase/shared/admob.dart';
import 'package:note_firebase/ui/product_detail.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HomeProductsCard extends StatefulWidget {
  @override
  _HomeProductsCardState createState() => _HomeProductsCardState();
}

class _HomeProductsCardState extends State<HomeProductsCard> {
  List<Products> items;
  final service = FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> noteSub;

  @override
  void initState() {
    super.initState();
    items = List();
    noteSub?.cancel();

    noteSub = service.getProductsList().listen((QuerySnapshot snapshot) {
      final List<Products> notes = snapshot.documents
          .map((documentSnapshot) => Products.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = notes;
      });
    });
  }

  @override
  void dispose() {
    noteSub?.cancel();
    super.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Produtos em destaques',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
              Text(
                'Ver todos',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        StreamBuilder<QuerySnapshot>(
          stream: service.getProductsList(limit: 2),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              items = snapshot.data.documents.map((doc)=>Products.fromMap(doc.data)).toList();
            }
            return Container(
              height: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (_, i){
                  return (i+1)%5 == 0 
                  ? Container(
                    width: 300,
                    color: Colors.red,
                    child: Center(child: Text('Item $i')),
                  ) 
                  : Container(
                    margin: EdgeInsets.only(right: 5, left: 10),
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black26,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 150,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            color: Colors.white,
                            /* boxShadow: [
                              BoxShadow(
                                blurRadius: 16,
                                offset: Offset(0, 5),
                                color: Colors.black54
                              ),
                            ], */
                            image: DecorationImage(
                              image: NetworkImage(items[i].imagem),
                              fit: BoxFit.cover
                            )
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                items[i].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    items[i].description.substring(0,20),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Ads().click();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ProductDetail(items[i])
                                        )
                                      );
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 30,                                    
                                      child: Icon(Icons.add_shopping_cart, size: 20, color: Colors.white,),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red[400],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              SmoothStarRating(
                                rating: items[i].rating,
                                color: Colors.yellow,
                                borderColor: Colors.yellow,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  );
                },                
              ),
            );
          }
        ),
      ],
    );
  }
}