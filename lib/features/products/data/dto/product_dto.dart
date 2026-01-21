class ProductDto {
  final int id;
  final String title;
  final double price;
  final String image;

  ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
    );
  }
}
