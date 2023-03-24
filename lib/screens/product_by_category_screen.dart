import 'package:flutter/material.dart';
import 'package:pet_adoption/provider/cat_provider.dart';
import 'package:pet_adoption/screens/product_list.dart';
import 'package:provider/provider.dart';

class ProductByCategory extends StatelessWidget {
  static const String id = 'product-by-cat';

  @override
  Widget build(BuildContext context) {
    var _catProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          _catProvider.selectedCategory,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(child: ProductList(true)),
    );
  }
}
