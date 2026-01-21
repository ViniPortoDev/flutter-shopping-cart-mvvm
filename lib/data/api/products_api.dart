import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/product_dto.dart';
import '../mappers/product_mapper.dart';
import '../../domain/entities/product.dart';

class ProductsApi {
  final http.Client client;

  ProductsApi({http.Client? client})
      : client = client ?? http.Client();

  Future<List<Product>> fetchProducts() async {
    final response = await client.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar produtos');
    }

    final List data = jsonDecode(response.body);

    return data
        .map((json) => ProductDto.fromJson(json).toEntity())
        .toList();
  }
}
