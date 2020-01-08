import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:note_firebase/model/products.dart';
import 'package:note_firebase/shared/admob.dart';
import 'package:note_firebase/ui/categories_list.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetail extends StatefulWidget {
  final Products products;

  ProductDetail(this.products);

  @override
  _ProductDetailState createState() => _ProductDetailState(products);
}

class _ProductDetailState extends State<ProductDetail> {
  final Products products;
  _ProductDetailState(this.products);

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen = 575.0;
  double _panelHeightClosed = 210;

  @override
  void initState(){
    super.initState();
    _fabHeight = _initFabHeight;
    Ads().click();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(products.title),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            backdropEnabled: true,
            parallaxOffset: .5,
            body: _body(),
            panel: _panel(),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            onPanelSlide: (double pos) => setState((){
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
            }),
          ),
          
          // categoria
          Positioned(
            left: 0.0,
            bottom: _fabHeight + 50,
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategoriesList(products.categoria)
                  )
                );
              },
              child: Chip(
                elevation: 12,
                backgroundColor: Colors.indigo,
                label: Text(
                  products.categoria,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    letterSpacing: 1
                  )
                ),
              ),
            ),
          ),

          // Button add_to_favorite
          Positioned(
            right: 20.0,
            bottom: _fabHeight + 60,
            child: Material(
              borderOnForeground: true,
              type: MaterialType.circle,
              color: Colors.white,
              elevation: 12,
              child: IconButton(
                iconSize: 35,
                icon: Icon(Icons.favorite),
                padding: EdgeInsets.all(10),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: Theme.of(context).errorColor,
                onPressed: (){},
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _panel(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 12.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(12.0))
              ),
            ),
          ],
        ),

        SizedBox(height: 18.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                products.title,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        SizedBox(height: 36.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _button(products.likes, Icons.thumb_up, Colors.blue),
            _button(products.minutos+ 'min.', Icons.timer, Colors.red),
            _button(products.calorias+ ' calor.', Icons.copyright, Colors.red),
            _button("400", Icons.share, Colors.indigo),
            _button(products.rating.toString(), Icons.star, Colors.amber[800]),
          ],
        ),

        SizedBox(height: 36.0,),

        Container(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text("Images", style: TextStyle(fontWeight: FontWeight.w600,)),

              SizedBox(height: 12.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                    CachedNetworkImage(
                      imageUrl: products.imagem,
                      height: 120.0,
                      width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                      fit: BoxFit.cover,
                    ),

                    CachedNetworkImage(
                      imageUrl: products.imagem,
                      width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),

                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 36.0,),

         Container(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("About", style: TextStyle(fontWeight: FontWeight.w600,)),

              SizedBox(height: 12.0,),

              Text(
                "Pittsburgh is a city in the Commonwealth of Pennsylvania "
                "in the United States, and is the county seat of Allegheny County. "
                "As of 2017, a population of 305,704 lives within the city limits, "
                "making it the 63rd-largest city in the U.S. The metropolitan population "
                "of 2,353,045 is the largest in both the Ohio Valley and Appalachia, "
                "the second-largest in Pennsylvania (behind Philadelphia), "
                "and the 26th-largest in the U.S.  Pittsburgh is located in the "
                "south west of the state, at the confluence of the Allegheny, "
                "Monongahela, and Ohio rivers, Pittsburgh is known both as 'the Steel City' "
                "for its more than 300 steel-related businesses and as the 'City of Bridges' "
                "for its 446 bridges. The city features 30 skyscrapers, two inclined railways, "
                "a pre-revolutionary fortification and the Point State Park at the "
                "confluence of the rivers. The city developed as a vital link of "
                "the Atlantic coast and Midwest, as the mineral-rich Allegheny "
                "Mountains made the area coveted by the French and British "
                "empires, Virginians, Whiskey Rebels, and Civil War raiders. ",
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),


      ],
    );
  }

  Widget _button(String label, IconData icon, Color color){
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )]
          ),
        ),

        SizedBox(height: 12.0,),

        Text(label),
      ],

    );
  }

  Widget _body(){
    return PageView(
      children: <Widget>[
        Container(
          color: Colors.red,
          child: Image.network(products.imagem, fit: BoxFit.cover),
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.green
        ),
      ],
    );
  }
}
