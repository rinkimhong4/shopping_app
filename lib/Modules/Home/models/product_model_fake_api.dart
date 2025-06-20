// ignore_for_file: constant_identifier_names

import 'dart:convert';

FakeApiClothing fakeApiClothingFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    return FakeApiClothing.fromJson(jsonData);
  } catch (e) {
    throw FormatException('Invalid JSON format: $e');
  }
}

String fakeApiClothingToJson(FakeApiClothing data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class FakeApiClothing {
  List<Product>? products;

  FakeApiClothing({this.products});

  factory FakeApiClothing.fromJson(Map<String, dynamic> json) {
    if (json['products'] == null) {
      return FakeApiClothing(products: []);
    }
    return FakeApiClothing(
      products: List<Product>.from(
        json['products'].map((x) => Product.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'products': products?.map((x) => x.toJson()).toList() ?? [],
  };
}

class Product {
  int? id;
  String? image;
  String? title;
  String? price;
  String? discount;
  Brand? brand;
  String? category;
  String? rate;
  String? description;

  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.discount,
    this.brand,
    this.category,
    this.rate,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      image: json['image']?.toString(),
      title: json['title']?.toString(),
      price: json['price']?.toString(),
      discount: json['discount']?.toString(),
      brand: json['brand'] != null ? brandValues.map[json['brand']] : null,
      category: json['category']?.toString(),
      rate: json['rate']?.toString(),
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'title': title,
    'price': price,
    'discount': discount,
    'brand': brand != null ? brandValues.reverse[brand] : null,
    'category': category,
    'rate': rate,
    'description': description,
  };
}

enum Brand { NIKE, ADIDAS }

final brandValues = EnumValues({'Nike': Brand.NIKE, 'Adidas': Brand.ADIDAS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
