import 'dart:convert';

ProductList productListFromJson(String str) =>
    ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  ProductList({
    required this.products,
    required this.total,
  });

  List<Product> products;
  int total;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
      products:
          List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      total: json["total"]);

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
      };
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.images,
  });

  int id;
  String title;
  String thumbnail;
  List<String> images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
