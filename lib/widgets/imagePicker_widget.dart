import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ImagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Upload image',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Column(
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  child: Icon(
                    CupertinoIcons.photo_on_rectangle,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: NeumorphicButton(
                      style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
