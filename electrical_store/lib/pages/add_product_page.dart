import 'package:flutter/material.dart';
import '../../database_helper.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController detailsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: 'Details'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final String name = nameController.text;
                final double price = double.parse(priceController.text);
                final String details = detailsController.text;

                await DatabaseHelper().addProduct(name, price, details);
                Navigator.pop(context);
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
