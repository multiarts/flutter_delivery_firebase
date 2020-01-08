import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/MenuIcons.dart';
import 'package:note_firebase/model/categories.dart';
import 'package:note_firebase/service/firebase_firestore_service.dart';
import 'package:note_firebase/shared/FadeAnimations.dart';
import 'package:note_firebase/ui/categories_list.dart';

class ListCategoriesWidget extends StatefulWidget {
  @override
  _ListCategoriesWidgetState createState() => _ListCategoriesWidgetState();
}

class _ListCategoriesWidgetState extends State<ListCategoriesWidget> {
  List<Categories> categories;
  FirebaseFirestoreService _service = FirebaseFirestoreService();
  
  @override
  void initState() {
    super.initState();
    categories = List();
  }

  @override
  Widget build(BuildContext context) {

    Map<String, IconData> _map = MenuIcons.values;
    
    return StreamBuilder(
      stream: _service.getCategories(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
          categories = snapshot.data.documents.map((doc) => Categories.fromMap(doc.data)).toList();
        }
        return Container(
          height: 105,
          // color: Colors.redAccent,
          // padding: EdgeInsets.symmetric(vertical: 5),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (_, index){
              return FadeAnimation(
                .0+index.toDouble(),
                GestureDetector(
                  onTap: (){
                    // print(categories[index].toMap());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoriesList(categories[index].title)),
                    );
                  },
                  child: Container(
                    // color: Colors.limeAccent,
                    padding: EdgeInsets.only(top: 5),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(left:10,right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 16,
                                offset: Offset(0, 5),
                                color: Colors.black45
                              ),
                            ],
                          ),
                          // child: Image.network(categories[index].icon)
                          child: Icon(_map[categories[index].icons],size: 36, color: Colors.redAccent),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            categories[index].title,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          
        );
      }
    );
  }
}