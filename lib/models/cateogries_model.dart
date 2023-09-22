class CategoryModel {
  int id;
  String? price;
  String? oldPrice;
  String? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;

  CategoryModel({
    required this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.inFavorites,
    this.inCart,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        price:
            json["price"]?.toString() == null ? "" : json["price"].toString(),
        oldPrice: json["old_price"]?.toString() == null
            ? ""
            : json["old_price"].toString(),
        discount: json["discount"]?.toString() == null ? "" : json["discount"].toString(),
        image: json["image"] == null ? "" : json["image"],
        name: json["name"] == null ? "" : json["name"],
        description: json["description"] == null ? "" : json["description"],

        inFavorites: json["in_favorites"] == null ? true : json["in_favorites"],
        inCart: json["in_cart"] == null ? true : json["in_cart"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,

        "in_favorites": inFavorites,
        "in_cart": inCart,
      };
}

// class CategoriesModel {
//   bool? status;
//   CategoriesDataModel? data;
//   CategoriesModel.fromJason(Map<String, dynamic> json) {
//     status = json['status'];
//     data = CategoriesDataModel.fromJason(json['data']);
//   }
// }
//
// class CategoriesDataModel {
//   int? currentPage;
//   List<DataModel> data = [];
//   CategoriesDataModel.fromJason(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     json['data'].forEach((element) {
//       data.add(DataModel.fromJason(element));
//     });
//   }
// }
//
// class DataModel {
//   int? id;
//   String name = '';
//   String image = '';
//   DataModel.fromJason(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//   }
// }