import 'package:flutter/widgets.dart';

class MenuIcons {
  MenuIcons._();

  static const _kFontFam = 'Flaticon';

  static const IconData pizza = const IconData(0xf100, fontFamily: _kFontFam);
  static const IconData sucos = const IconData(0xf101, fontFamily: _kFontFam);
  static const IconData sanduiche = const IconData(0xf102, fontFamily: _kFontFam);
  static const IconData sorvetes = const IconData(0xf103, fontFamily: _kFontFam);
  static const IconData doces = const IconData(0xf104, fontFamily: _kFontFam);
  static const IconData paes = const IconData(0xf105, fontFamily: _kFontFam);
  static const IconData cafe = const IconData(0xf106, fontFamily: _kFontFam);
  static const IconData waffle = const IconData(0xf107, fontFamily: _kFontFam);

  static const Map<String, IconData> _map = {
    'pizza': pizza,
    'sucos': sucos,
    'sanduiche': sanduiche,
    'sorvetes': sorvetes,
    'doces': doces,
    'paes': paes,
    'cafe': cafe,
    'waffle': waffle,
  };

  static Map<String, IconData> get values => _map;
}