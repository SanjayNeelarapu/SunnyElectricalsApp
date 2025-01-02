import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const ProductManagementApp());
}

class ProductManagementApp extends StatelessWidget {
  const ProductManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Management System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
