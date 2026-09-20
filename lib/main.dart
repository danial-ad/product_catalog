import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/providers/product_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: const ProductCatalogApp(),
    ),
  );
}

class ProductCatalogApp extends StatelessWidget {
  const ProductCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Catalog',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Product Catalog'),
        ),
        body: const Center(
          child: Text('Product Catalog'),
        ),
      ),
    );
  }
}