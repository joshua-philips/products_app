class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'].toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: Rating.fromJson(json['rating']),
    );
  }
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'] as int,
    );
  }
}
