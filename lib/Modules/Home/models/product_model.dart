import 'dart:convert';

List<TShirtModel> tShirtModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<TShirtModel>.from(jsonData.map((x) => TShirtModel.fromJson(x)));
}

String tShirtModelToJson(List<TShirtModel> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class TShirtModel {
  int? id;
  String? title;
  double? price;
  String? description;
  Category? category;
  String? image;
  Rating? rating;

  TShirtModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory TShirtModel.fromJson(Map<String, dynamic> json) => TShirtModel(
    id: json["id"],
    title: json["title"],
    price: (json["price"] ?? 0).toDouble(),
    description: json["description"],
    category: categoryValues.map[json["category"]],
    image: json["image"],
    rating: json["rating"] != null ? Rating.fromJson(json["rating"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": categoryValues.reverse[category],
    "image": image,
    "rating": rating?.toJson(),
  };
}

enum Category { MEN_S_CLOTHING, JEWELERY, ELECTRONICS, WOMEN_S_CLOTHING }

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING,
});

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(rate: (json["rate"] ?? 0).toDouble(), count: json["count"] ?? 0);

  Map<String, dynamic> toJson() => {"rate": rate, "count": count};
}

class EnumValues<T> {
  Map<String, T> map;

  EnumValues(this.map);

  Map<T, String> get reverse => map.map((k, v) => MapEntry(v, k));
}
