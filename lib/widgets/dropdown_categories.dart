import 'package:flutter/material.dart';
 
class DropDownCategories extends StatefulWidget {
  DropDownCategories() : super();
 
  final String title = "DropDownCategories Demo";
 
  @override
  DropDownCategoriesState createState() => DropDownCategoriesState();
}
 
class Company {
  int id;
  String name;
 
  Company(this.id, this.name);
 
  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Apple'),
      Company(2, 'Google'),
      Company(3, 'Samsung'),
      Company(4, 'Sony'),
      Company(5, 'LG'),
    ];
  }
}
 
class DropDownCategoriesState extends State<DropDownCategories> {
  //
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;
 
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }
 
  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Select a company"),
            SizedBox(
              height: 20.0,
            ),
            DropdownButton(
              value: _selectedCompany,
              items: _dropdownMenuItems,
              onChanged: onChangeDropdownItem,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('Selected: ${_selectedCompany.name}'),
          ],
        ),
      ),
    );
  }
}