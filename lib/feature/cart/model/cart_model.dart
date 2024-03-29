// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartModel {
  int id;
  int userId;
  DateTime date;
  List<ProductCartModel> products;
  int v;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<ProductCartModel>.from(json["products"].map((x) => ProductCartModel.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "__v": v,
      };

  CartModel copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<ProductCartModel>? products,
    int? v,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      products: products ?? this.products,
      v: v ?? this.v,
    );
  }
}

class ProductCartModel {
  int productId;
  int quantity;

  ProductCartModel({
    required this.productId,
    required this.quantity,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) => ProductCartModel(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };

  ProductCartModel copyWith({
    int? productId,
    int? quantity,
  }) {
    return ProductCartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
