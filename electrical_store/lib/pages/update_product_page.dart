import 'package:flutter/material.dart';
import '../../database_helper.dart';

class UpdateProductPage extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productDetails;

  const UpdateProductPage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productDetails,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: productName);
    final TextEditingController priceController =
        TextEditingController(text: productPrice.toString());
    final TextEditingController detailsController =
        TextEditingController(text: productDetails);

    return Scaffold(
      appBar: AppBar(title: const Text('Update Product')),
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
                await DatabaseHelper().updateProduct(
                  productName,
                  nameController.text,
                  double.parse(priceController.text),
                  detailsController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
