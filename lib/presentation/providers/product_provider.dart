import 'package:flutter/foundation.dart';
import '../../data/models/product.dart';
import '../../data/services/product_api_service.dart';


class ProductProvider extends ChangeNotifier {
  final ProductApiService _apiService = ProductApiService();
  
  List<Product> products = [];

  bool isLoading = false;
  String? errorMessage;
  int skip = 0;
  final int limit = 20;

  bool isLoadingMore = false;
  bool hasMore = true;

  Future<void> fetchProducts() async {
  isLoading = true;
  errorMessage = null;
  skip = 0;
  hasMore = true;

  notifyListeners();

  try {
    products = await _apiService.getProducts(
      limit: limit,
      skip: skip,
    );

    skip += limit;
  } catch (e) {
    errorMessage = 'Failed to load products';
  }

  isLoading = false;
  notifyListeners();
}
Future<void> loadMoreProducts() async {
  if (isLoadingMore || !hasMore) {
    return;
  }

  isLoadingMore = true;
  notifyListeners();

  try {
    final newProducts = await _apiService.getProducts(
      limit: limit,
      skip: skip,
    );

    products.addAll(newProducts);
    skip += newProducts.length;

    if (newProducts.length < limit) {
      hasMore = false;
    }
  } catch (e) {
    errorMessage = 'Failed to load more products';
  }

  isLoadingMore = false;
  notifyListeners();
}
}