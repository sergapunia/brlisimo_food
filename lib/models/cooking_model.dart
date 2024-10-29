class Cooking {
  String name;
  String image;
  String? description;
  List<dynamic> ingredients;
  List<dynamic> instructions;
  List<dynamic> imageInstructions;
  Cooking({
    required this.name,
    required this.image,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.imageInstructions,
  });

  factory Cooking.fromJson(Map<String, dynamic> json) {
    return Cooking(
      name: json["name"],
      image: json["image"],
      description: json["description"],
      ingredients: json["ingredients"],
      instructions: json["instructions"],
      imageInstructions: json["image_instructions"],
    );
  }
}
