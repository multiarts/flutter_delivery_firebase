class Categories{
  String _id, _title, _icon;
  String _icons;

  Categories(this._id, this._title, this._icon, this._icons);

  Categories.map(dynamic obj){
    this._id = obj["_id"];
    this._title = obj["_title"];
    this._icon = obj["_icon"];
    this._icons = obj["_icons"];
  }

  String get id => _id;
  String get title => _title;
  String get icon => _icon;
  String get icons => _icons;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['icon'] = _icon;
    map['icons'] = _icons;
 
    return map;
  }

  Categories.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._icon = map['icon'];
    this._icons = map['icons'];
  }
  
}