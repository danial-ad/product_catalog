import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts({
  int limit = 20,
  int skip = 0,
}) async {
  final response = await http.get(
    Uri.parse(
      '$baseUrl/products?limit=$limit&skip=$skip',
    ),
  );

  // (test for the status api)
  // print(response.statusCode);
  // print(response.body);
  final data = jsonDecode(response.body);
  final productList = (data['products'] as List)
    .map((json) => Product.fromJson(json as Map<String, dynamic>))
    .toList();
  return productList;

  
}
Future<Product> getProductById(int id) async {
  final response = await http.get(
    Uri.parse('$baseUrl/products/$id'),
  );

  final data = jsonDecode(response.body);

  return Product.fromJson(data);
}
}