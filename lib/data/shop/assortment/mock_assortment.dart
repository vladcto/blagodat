import 'package:blagodat/data/shop/assortment/assortment.dart';
import 'package:blagodat/data/shop/info/product.dart';

/// Моковый класс для тестовой выборки продуктов.
class MockAssortment implements Assortment {
  static final _products = [
    Product(
      uid: _AutoId.id,
      name: "Аромат Паленных Дров",
      description:
          """ Это благовоние является настоящим сокровищем из затерянного мира Атлантиды. 
    Сочетание нот морской соли, драгоценных древесных смол и мистического ладана перенесет вас в глубины древних океанов и пробудит вашу связь с магическими энергиями природы. 
Этот аромат позволит вам открыть древние знания и усилить свою интуицию.""",
      imageURL: [
        "https://upload.wikimedia.org/wikipedia/commons/6/6b/Eastern_Orthodox_man_in_Jerusalem_by_David_Shankbone.jpg",
        "https://ir.ozone.ru/s3/multimedia-i/wc500/6647844690.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/6/6b/Eastern_Orthodox_man_in_Jerusalem_by_David_Shankbone.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/6/6b/Eastern_Orthodox_man_in_Jerusalem_by_David_Shankbone.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/6/6b/Eastern_Orthodox_man_in_Jerusalem_by_David_Shankbone.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/6/6b/Eastern_Orthodox_man_in_Jerusalem_by_David_Shankbone.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/6/6b/Eastern_Orthodox_man_in_Jerusalem_by_David_Shankbone.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/6/6b/Eastern_Orthodox_man_in_Jerusalem_by_David_Shankbone.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/6/6b/Eastern_Orthodox_man_in_Jerusalem_by_David_Shankbone.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/6/6b/Eastern_Orthodox_man_in_Jerusalem_by_David_Shankbone.jpg",
      ],
      cost: 0.99,
    ),
  ];

  @override
  List<Product> get products => _products;
}

/// Класс предоставляющий сервис для получения UID.
class _AutoId {
  static int _i = 0;

  static String get id {
    return (_i++).toString();
  }
}
