import 'package:flutter/foundation.dart';
import '../../data/models/product.dart';
import '../../data/services/product_api_service.dart';
import 'dart:async';

class ProductProvider extends ChangeNotifier {
  final ProductApiService _apiService = ProductApiService();
  Timer? _searchDebounce;
  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
  
  List<Product> products = [];

  bool isLoading = false;
  String? errorMessage;
  int skip = 0;
  final int limit = 20;

  bool isSearching = false;
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

void searchProducts(String query) {
  _searchDebounce?.cancel();

  if (query.trim().isEmpty) {
    isSearching = false;
    fetchProducts();
    return;
  }

  isSearching = true;

  _searchDebounce = Timer(
    const Duration(milliseconds: 500),
    () async {
      isLoading = true;
      errorMessage = null;

      notifyListeners();

      try {
        products = await _apiService.searchProducts(query);
      } catch (e) {
        errorMessage = 'Failed to search products';
      }

      isLoading = false;
      notifyListeners();
    },
  );
}
Future<void> loadMoreProducts() async {
  if (isLoadingMore || !hasMore || isSearching) {
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