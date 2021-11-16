import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/services/firebase_services.dart';
import 'package:pet_adoption/widgets/product_card.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: FutureBuilder<QuerySnapshot>(
          future: _service.products.orderBy('postedAt').get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(left: 140, right: 140),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                  backgroundColor: Colors.grey.shade100,
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 56,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Fresh Recommendations',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2.2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data.size,
                  itemBuilder: (BuildContext context, int i) {
                    var data = snapshot.data.docs[i];

                    return ProductCard(data: data);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


