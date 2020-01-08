import 'package:flutter/material.dart';

class BottomCardButton extends StatefulWidget {
  _BottomCardButtonState createState() => _BottomCardButtonState();
}

class _BottomCardButtonState extends State<BottomCardButton> {
  @override
  Widget build(BuildContext context) {
    return BottomNavyBar();
  }
}

class BottomNavyBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomNavyBarState();
  }
}

class BottomNavyBarState extends State<BottomNavyBar> {
  int selectedIndex = 0;

  List<NavigationItem> itemsNavy = [
    NavigationItem(
        Icon(Icons.home), Text("Home"), Colors.indigo[700], Colors.indigo[100]),
    NavigationItem(Icon(Icons.format_list_bulleted), Text("Categoria"),
        Colors.orange[900], Colors.orange[100]),
    NavigationItem(Icon(Icons.shopping_cart), Text("Carrinho"),
        Colors.teal[700], Colors.teal[100]),
    NavigationItem(Icon(Icons.person_outline), Text("Perfil"), Colors.cyan[700],
        Colors.cyan[100]),
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: double.maxFinite,
      width: isSelected ? 130 : 50,
      padding: isSelected ? EdgeInsets.only(left: 10, right: 10) : null,
      decoration: isSelected
          ? BoxDecoration(
              color: item.corBg,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            )
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                    size: 24,
                    color: isSelected ? item.corText : Colors.white70),
                child: item.icon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: isSelected
                    ? DefaultTextStyle.merge(
                        style: TextStyle(
                            color: isSelected ? item.corText : Colors.black),
                        child: item.title)
                    : Container(),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color(0xFF383B42);
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only( top: 40, bottom: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        /* boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 18,
              offset: Offset(0, 0)
            )
          ]  */
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: itemsNavy.map((item) {
          var itemIndex = itemsNavy.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = itemIndex;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: _buildItem(item, selectedIndex == itemIndex),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;
  final Color corText;
  final Color corBg;

  NavigationItem(this.icon, this.title, this.corText, this.corBg);
}
