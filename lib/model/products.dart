class Products {
  String _id;
  String _title;
  String _description;
  String _likes;
  String _calorias;
  String _minutos;
  double _rating;
  String _imagem;
  double _valor;
  String _categoria;

  Products(
    this._id, 
    this._title, 
    this._description, 
    this._likes, 
    this._calorias, 
    this._minutos, 
    this._rating, 
    this._imagem, 
    this._valor, 
    this._categoria
  );

  Products.map(dynamic obj) {
    this._id = obj['_id'];
    this._title = obj['_title'];
    this._description = obj['_description'];
    this._likes = obj['_likes'];
    this._calorias = obj['_calorias'];
    this._minutos = obj['_minutos'];
    this._rating = obj['_rating'];
    this._imagem = obj['_imagem'];
    this._valor = obj['_valor'];
    this._categoria = obj['_categoria'];
  }

  String get id => _id;
  String get title => _title;
  String get description => _description;
  String get likes => _likes;
  String get calorias => _calorias;
  String get minutos => _minutos;
  double get rating => _rating;
  String get imagem => _imagem;
  String get categoria => _categoria;
  double get valor => _valor;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['likes'] = _likes;
    map['calorias'] = _calorias;
    map['minutos'] = _minutos;
    map['rating'] = _rating;
    map['imagem'] = _imagem;
    map['valor'] = _valor;
    map['categoria'] = _categoria;
 
    return map;
  }

  Products.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._likes = map['likes'];
    this._calorias = map['calorias'];
    this._minutos = map['minutos'];
    this._rating = map['rating'] + 0.0;
    this._imagem = map['imagem'];
    this._valor = map['valor'];
    this._categoria = map['categoria'];
  }
}