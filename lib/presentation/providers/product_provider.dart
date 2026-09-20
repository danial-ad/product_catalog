import 'package:flutter/foundation.dart';
import '../../data/models/product.dart';
import '../../data/services/product_api_service.dart';


class ProductProvider extends ChangeNotifier {
  final ProductApiService _apiService = ProductApiService();
  
  List<Product> products = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchProducts() async {
  isLoading = true;
  errorMessage = null;
  notifyListeners();

  try {
    products = await _apiService.getProducts();
  } catch (e) {
    errorMessage = 'Failed to load products';
  }

  isLoading = false;
  notifyListeners();
}
}