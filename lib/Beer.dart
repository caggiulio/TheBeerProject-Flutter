

class Beer {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  Beer({this.name, this.id, this.description, this.imageUrl});

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url']
    );
  }
}