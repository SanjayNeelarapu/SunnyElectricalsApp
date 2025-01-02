// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../database_helper.dart';
import 'add_product_page.dart';
import 'update_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final products =
        await _dbHelper.getProducts(searchQuery: _searchController.text);
    setState(() {
      _products = products;
    });
  }

  Future<void> _deleteProduct(String name) async {
    await _dbHelper.deleteProduct(name);
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Management System')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Products by Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _fetchProducts(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text(
                      'Price: \$${product['price']}\nDetails: ${product['details']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateProductPage(
                                productName: product['name'],
                                productPrice: product['price'],
                                productDetails: product['details'],
                              ),
                            ),
                          ).then((_) => _fetchProducts());
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProduct(product['name']),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductPage()),
          ).then((_) => _fetchProducts());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
