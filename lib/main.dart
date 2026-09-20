import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/product_list_screen.dart';

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
      title: 'Products Catalog',
      home: const ProductListScreen(),
    );
  }
}