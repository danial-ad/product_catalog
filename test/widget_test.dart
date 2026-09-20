import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/data/models/product.dart';

void main() {
  test('Product.fromJson creates a product correctly', () {
    final json = {
      'id': 1,
      'title': 'Test Product',
      'description': 'Test description',
      'price': 10.99,
      'rating': 4.5,
      'thumbnail': 'https://example.com/image.jpg',
      'images': [
        'https://example.com/image1.jpg',
      ],
    };

    final product = Product.fromJson(json);

    expect(product.id, 1);
    expect(product.title, 'Test Product');
    expect(product.price, 10.99);
    expect(product.rating, 4.5);
  });
}