import 'package:flutter/material.dart';
import 'package:note_firebase/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        accentColor: Color(0xFF323132),
        appBarTheme: AppBarTheme(
          color: Color(0xFF323132),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white
          ),
        ),
        fontFamily: 'Comfortaa'
      ),
      home: ProductsList(),
      // home: NewLoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


