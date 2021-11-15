import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_adoption/services/firebase_services.dart';

class CategoryProvider with ChangeNotifier{

  FirebaseService _service = FirebaseService();

  DocumentSnapshot doc;
  String selectedCategory;
  List<String> urlList = [];
  Map<String,dynamic> dataToFirestore = {};

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

  getData(data){
    this.dataToFirestore = data;
    notifyListeners();
  }

  getUserDetails(){
    _service.getUserData();
  }

}

