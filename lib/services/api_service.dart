import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projectone/models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  //GET ALL
  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    _checkResponse(response);
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((item) => Product.fromJson(item)).toList();
  }

  //GET SINGLE
  static Future<Product> getProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    _checkResponse(response);
    return Product.fromJson(jsonDecode(response.body));
  }

  //CREATE
  static Future<Product> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );
    _checkResponse(response);
    return Product.fromJson(jsonDecode(response.body));
  }

  //UPDATE
  static Future<Product> updateProduct(int id, Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );
    _checkResponse(response);
    return Product.fromJson(jsonDecode(response.body));
  }

  //DELETE
  static Future<bool> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200;
  }

  // Throws a clear exception for bad responses — prevents jsonDecode("")
  static void _checkResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      );
    }
    if (response.body.trim().isEmpty) {
      throw Exception('Server returned an empty response.');
    }
  }
}