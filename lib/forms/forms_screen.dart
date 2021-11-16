import 'package:flutter/material.dart';
import 'package:pet_adoption/forms/form_class.dart';
import 'package:pet_adoption/provider/cat_provider.dart';
import 'package:provider/provider.dart';

class FormsScreen extends StatefulWidget {
  static const String id = 'form-screen';

  @override
  _FormsScreenState createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  var _breedText = TextEditingController();
  FormClass _formClass = FormClass();

  @override
  Widget build(BuildContext context) {

    var _provider = Provider.of<CategoryProvider>(context);

    showFormDialog(){
      return showDialog(context: context, builder: (BuildContext context){
        return Dialog(
          child: Column(
            children: [
              _formClass.appBar(_provider),

            ],
          ),
        );
      });
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_provider.selectedCategory} > ${_provider.selectedSubCat}'),
            InkWell(
              onTap: (){
                showFormDialog();
              },
              child: TextFormField(
                controller: _breedText,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Breeds',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
