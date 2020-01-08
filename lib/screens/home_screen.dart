import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/shared/admob.dart';
import 'package:note_firebase/widgets/bottom_card_buttons.dart';
import 'package:note_firebase/widgets/home_products_card.dart';
import 'package:note_firebase/widgets/list_categories_widget.dart';

class ProductsList extends StatefulWidget {
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  // BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  static final MobileAdTargetingInfo targetInfo = MobileAdTargetingInfo(
    keywords: <String>['flutter', 'sanduiche', 'coxinha', 'sucos', 'doces', 'salgados'],
    childDirected: true,
    testDevices: <String>[],
  );

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: "ca-app-pub-2751513292355996/4309664960" ,
      targetingInfo: targetInfo,
      listener: (MobileAdEvent event) {
        print("Interstitial event : $event");
      });
  }

  @override
  void initState() {
    super.initState();
    // FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-2751513292355996~5195371220');
    Future.delayed(
      const Duration(milliseconds: 1000*20), (){
        setState(() {
        Ads().click();
        });
      }
    );
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Doces & Salgados",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).errorColor,
          ),
        ),
        centerTitle: true,
        leading: Icon(Icons.restaurant),
        actions: <Widget>[
          Container(alignment: Alignment.center,
            child: IconButton(
              icon: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink
                    ),
                    child: Text(
                      "15",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12)),
                  )
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            child: IconButton(
              iconSize: 30,
              icon: Stack(
                overflow: Overflow.visible,
                // alignment: Alignment.center,
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: Container(
                      width: 56,
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink
                      ),
                      child: Text(
                        "5",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                    ),
                  )
                ],
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      
      // bottomNavigationBar: BottomCardButton(),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomCardButton(),
          ),
          Container(
            height: imageHeight * .83,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 19,
                  offset: Offset(0, -4)
                )
              ],
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).accentColor,
                  // Colors.white
                ],
                begin: Alignment.topCenter,
                stops: [.5,0]
              )
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 20),
              child: Column(      
                children: <Widget>[
                  // DropDownCategories(),
                  ListCategoriesWidget(),
                  SizedBox(height: 40),
                  HomeProductsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}