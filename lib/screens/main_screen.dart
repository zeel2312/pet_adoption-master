import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/screens/account_screen.dart';
import 'package:pet_adoption/screens/chat_screen.dart';
import 'package:pet_adoption/screens/home_screen.dart';
import 'package:pet_adoption/screens/myAd_screen.dart';
import 'package:pet_adoption/screens/sellitems/seller_category_list.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main-screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Widget _currentScreen = HomeScreen();
  int _index = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {

    Color color = Theme.of(context).primaryColor;

    return Scaffold(
      body: PageStorage(
        child: _currentScreen,
        bucket: _bucket,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, SellerCategory.id);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _index = 0;
                        _currentScreen = HomeScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index == 0 ? Icons.home : Icons.home_outlined),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: _index == 0 ? color : Colors.black,
                            fontWeight: _index==0 ? FontWeight.bold : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _index = 1;
                        _currentScreen = ChatScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index == 1 ? CupertinoIcons.chat_bubble_fill : CupertinoIcons.chat_bubble),
                        Text(
                          'CHATS',
                          style: TextStyle(
                            color: _index == 1 ? color : Colors.black,
                            fontWeight: _index==1 ? FontWeight.bold : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _index = 2;
                        _currentScreen = MyAdsScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index == 2 ? CupertinoIcons.heart_fill : CupertinoIcons.heart),
                        Text(
                          'MY ADS',
                          style: TextStyle(
                            color: _index == 2 ? color : Colors.black,
                            fontWeight: _index==2 ? FontWeight.bold : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _index = 3;
                        _currentScreen = AccountScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index == 3 ? CupertinoIcons.person_fill : CupertinoIcons.person),
                        Text(
                          'ACCOUNT',
                          style: TextStyle(
                            color: _index == 3 ? color : Colors.black,
                            fontWeight: _index==3 ? FontWeight.bold : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
