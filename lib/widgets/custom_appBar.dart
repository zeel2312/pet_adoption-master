import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/screens/home_screen.dart';
import 'package:pet_adoption/screens/location_screen.dart';
import 'package:pet_adoption/services/firebase_services.dart';


class CustomAppBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();


    return FutureBuilder<DocumentSnapshot>(
      future: _service.users.doc(_service.user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Address not selected");
        }

        if (snapshot.connectionState==ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();

          if(data['address']==null){
            GeoPoint latLong = data['location'];
            _service.getAddress(latLong.latitude, latLong.longitude).then((adres){
              return appBar(adres, context);
            });
          }else{
            return appBar(data['address'], context);
          }
        }

        return appBar('Fetching location..', context);
      },
    );
  }

  Widget appBar(address,context){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LocationScreen(popScreen: HomeScreen.id,),
            ),);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 8,bottom: 8),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.black,
                  size: 18,
                ),
                Flexible(
                  child: Text(
                    address,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,size: 18,),
              ],
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(56),

        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,),
                        labelText: 'Find cats, dogs and many more',
                        labelStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.only(left: 10,right: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Icon(Icons.notifications_none),
                SizedBox(width: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
