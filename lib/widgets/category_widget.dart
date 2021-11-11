import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/services/firebase_services.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: _service.catagories.get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            return Container(
              height: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('categories')),
                      TextButton(onPressed: (){},
                        child: Row(
                          children: [
                            Text('See all',style: TextStyle(color: Colors.black),),
                            Icon(Icons.arrow_forward_ios,size: 12,color: Colors.black,)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context,int index){

                        var doc = snapshot.data.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 60,
                            height: 50,
                            child: Column(
                              children: [
                                Image.network(doc['image']),
                                Flexible(
                                  child: Text(
                                    doc['catName'],
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                    },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}