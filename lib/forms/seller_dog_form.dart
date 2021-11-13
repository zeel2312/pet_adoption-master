import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pet_adoption/provider/cat_provider.dart';
import 'package:provider/provider.dart';

class SellerDogForm extends StatefulWidget {
  static const String id = 'dog-form';

  @override
  _SellerDogFormState createState() => _SellerDogFormState();
}

class _SellerDogFormState extends State<SellerDogForm> {
  final _formKey = GlobalKey<FormState>();

  var _brandController = TextEditingController();
  // var _ageController = TextEditingController();
  var _infoController = TextEditingController();

  validate(){
    if(_formKey.currentState.validate()){
      print('Validated');
    }
  }

  @override
  Widget build(BuildContext context) {

    var _catProvider = Provider.of<CategoryProvider>(context);

    Widget _appBar(){
      return AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        title: Text('${_catProvider.selectedCategory} > breeds',style: TextStyle(color: Colors.black,fontSize: 15),),
      );
    }

    Widget _breedList(){
      return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                _appBar(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _catProvider.doc['breed'].length,
                      itemBuilder: (BuildContext context,int index){
                        return ListTile(
                          onTap: (){
                            setState(() {
                              _brandController.text = _catProvider.doc['breed'][index];
                            });
                            Navigator.pop(context);
                          },
                          title: Text(_catProvider.doc['breed'][index]),
                        );
                      }),
                ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DOG',style: TextStyle(fontWeight: FontWeight.bold),),
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return _breedList();
                    });
                  },
                  child: TextFormField(
                    controller: _brandController,
                    enabled: false,
                    decoration: InputDecoration(labelText: 'Breed'),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },
                  ),
                ),
                //see what is the output once it is done
                // TextFormField(
                //   controller: _ageController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(
                //     labelText: 'Age',
                //   ),
                //   validator: (value){
                //     if(value.isEmpty){
                //       return null;//'Please complete required field'
                //     }
                //     return null;
                //   },
                // ),
                TextFormField(
                  controller: _infoController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Information',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please complete required field';//'Please complete required field'
                    }
                    return null;
                  },
                ),

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
