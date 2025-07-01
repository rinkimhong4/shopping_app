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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
    image: json['image']?.toString(),
    title: json['title']?.toString(),
    price: json['price']?.toString(),
    discount: json['discount']?.toString(),
    brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
    category: json['category']?.toString(),
    rate: json['rate']?.toString(),
    description: json['description']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'title': title,
    'price': price,
    'discount': discount,
    'brand': brand?.toJson(),
    'category': category,
    'rate': rate,
    'description': description,
  };
}

class Brand {
  String? name;
  String? logo;

  Brand({this.name, this.logo});

  factory Brand.fromJson(Map<String, dynamic> json) =>
      Brand(name: json['name']?.toString(), logo: json['logo']?.toString());

  Map<String, dynamic> toJson() => {'name': name, 'logo': logo};
}
