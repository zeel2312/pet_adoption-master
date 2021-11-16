import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:pet_adoption/screens/home_screen.dart';

class FirebaseService {

  User user = FirebaseAuth.instance.currentUser;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  CollectionReference products = FirebaseFirestore.instance.collection('products');


  Future<void> updateUser(Map<String,dynamic>data,context,screen) {
    return users
        .doc(user.uid)
        .update(data)
        .then((value) {
          Navigator.pushNamed(context, screen);
    },)
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update location'),
        ),
      );
    });
  }

  Future<String>getAddress(lat,long)async{
    final coordinates = new Coordinates(lat,long);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    return first.addressLine;
  }

  Future<DocumentSnapshot>getUserData()async{
    DocumentSnapshot doc = await users.doc(user.uid).get();
    return doc;
  }

  Future<DocumentSnapshot>getSellerData(id)async{
    DocumentSnapshot doc = await users.doc(id).get();
    return doc;
  }

}