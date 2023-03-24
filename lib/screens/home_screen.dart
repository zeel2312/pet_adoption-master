import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/provider/cat_provider.dart';
import 'package:pet_adoption/screens/product_list.dart';
import 'package:pet_adoption/widgets/banner_widget.dart';
import 'package:pet_adoption/widgets/category_widget.dart';
import 'package:pet_adoption/widgets/custom_appBar.dart';
import 'package:provider/provider.dart';
import 'location_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'India';

  @override
  Widget build(BuildContext context) {

    var _catProvider = Provider.of<CategoryProvider>(context);
    _catProvider.clearSelectedCat();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(
          child: CustomAppBar(),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Column(
                  children: [
                    BannerWidget(),
                    CategoryWidget(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            ProductList(false),
          ],
        ),
      ),
    );
  }
}
