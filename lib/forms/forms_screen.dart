import 'package:flutter/material.dart';
import 'package:pet_adoption/provider/cat_provider.dart';
import 'package:provider/provider.dart';

class FormsScreen extends StatelessWidget {
  static const String id = 'form-screen';

  @override
  Widget build(BuildContext context) {

    var _provider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text(
          'Add some details',
          style: TextStyle(color: Colors.black),
        ),
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('${_provider.selectedCategory} > ${_provider.selectedSubCat}'),
          ],
        ),
      ),
    );
  }
}
