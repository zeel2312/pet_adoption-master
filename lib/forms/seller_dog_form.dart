import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SellerDogForm extends StatelessWidget {
  static const String id = 'dog-form';
  final _formKey = GlobalKey<FormState>();

  validate(){
    if(_formKey.currentState.validate()){
      print('Validated');
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget _appBar(title){
      return AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        title: Text('$title > breed',style: TextStyle(color: Colors.black,fontSize: 15),),
      );
    }

    Widget _breedList(){
      return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _appBar('Dogs'),
                ListView.builder(itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    title:Text('gdgd') ,
                  );
                }),
              ],
            ),
      );
    }







    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text(
          'Add some details',
          style: TextStyle(color: Colors.black),
        ),
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text('PET'),
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return _breedList();
                    });
                  },
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(labelText: 'Animal/Bird'),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                onPressed: () {
                  validate();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
