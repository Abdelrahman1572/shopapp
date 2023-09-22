class SearchModel {
  int id;
  double price;
  String image;
  String name;
  String description;
  bool inFavorites;
  bool inCart;

  SearchModel({
    required this.id,
    required this.price,
    required this.image,
    required this.name,
    required this.description,
    required this.inFavorites,
    required this.inCart,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: (json["id"] == null) ? 0 : json["id"],
        price: (json["price"]?.toDouble() == null)
            ? 0.0
            : json["price"].toDouble(),
        image: (json["image"] == null) ? "" : json["image"],
        name: (json["name"] == null) ? "" : json["name"],
        description: (json["description"] == null) ? "" : json["description"],
        inFavorites:
            (json["in_favorites"] == null) ? false : json["in_favorites"],
        inCart: (json["in_cart"] == null) ? false : json["in_cart"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "image": image,
        "name": name,
        "description": description,
        "in_favorites": inFavorites,
        "in_cart": inCart,
      };
}
