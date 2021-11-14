import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier{

  DocumentSnapshot doc;
  String selectedCategory;
  List<String> urlList =[];

  getCategory(selectedCat){
    this.selectedCategory = selectedCat;
    notifyListeners();
  }

  getCatSnapshot(snapshot){
    this.doc = snapshot;
    notifyListeners();
  }

   getImages(url){
    this.urlList.add(url);
    notifyListeners();
  }
}

