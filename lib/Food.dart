class Food {
  final String name;
  final String imageURL;

  Food({this.name, this.imageURL});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json["food_name"],
      imageURL: json["image"]
    );
  }
}