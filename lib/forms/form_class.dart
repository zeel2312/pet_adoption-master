import 'package:flutter/material.dart';
import 'package:pet_adoption/provider/cat_provider.dart';

class FormClass {
  Widget appBar(CategoryProvider _provider) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      shape: Border(bottom: BorderSide(color: Colors.grey.shade300),),
      title: Text(
        _provider.selectedSubCat,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
