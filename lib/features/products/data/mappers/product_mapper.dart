import '../../domain/entities/product.dart';
import '../dto/product_dto.dart';

extension ProductMapper on ProductDto {
  Product toEntity() {
    return Product(
      id: id,
      title: title,
      image: image,
      price: price,
    );
  }
}
