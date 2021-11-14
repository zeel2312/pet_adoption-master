import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:pet_adoption/provider/cat_provider.dart';
import 'package:pet_adoption/services/firebase_services.dart';
import 'package:pet_adoption/widgets/imagePicker_widget.dart';
import 'package:provider/provider.dart';

class SellerDogForm extends StatefulWidget {
  static const String id = 'dog-form';

  @override
  _SellerDogFormState createState() => _SellerDogFormState();
}

class _SellerDogFormState extends State<SellerDogForm> {
  final _formKey = GlobalKey<FormState>();

  FirebaseService _service = FirebaseService();

  var _breedController = TextEditingController();
  var _careController = TextEditingController();
  // var _ageController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _addressController = TextEditingController();





  validate(CategoryProvider provider) {
    if (_formKey.currentState.validate()) {

      if(provider.urlList.isNotEmpty){
        provider.dataToFirestore.addAll({
          'category' : provider.selectedCategory,
          'breed' : _breedController.text,
          'care' : _careController.text,
          'description' : _descriptionController.text,
          'address' : _addressController.text,
          'sellerUid' : _service.user.uid,
          'images' : provider.urlList,
        });

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image not uploaded'),
          ),
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please complete required fields..'),
          ),
      );
    }
  }

  List<String> _careList = [
    'For Adoption',
    'Need Treatment',
    'Finding Temporary Home',
    'Finding Trainer',
    'Missing Pet'
  ];

  @override
  void initState() {
    _service.getUserData().then((value) {
      setState(() {
        _addressController.text = value['address'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _catProvider = Provider.of<CategoryProvider>(context);

    Widget _appBar(title, fieldValue) {
      return AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300),),
        title: Text(
          '$title > $fieldValue',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
    }

    Widget _breedList() {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar(_catProvider.selectedCategory, 'breed'),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: _catProvider.doc['breed'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          _breedController.text =
                              _catProvider.doc['breed'][index];
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

    Widget _listView({fieldValue, list, textController}) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar(_catProvider.selectedCategory, fieldValue),
            ListView.builder(
              shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  textController.text = list[index];
                  Navigator.pop(context);
                },
                title: Text(list[index]),
              );
            })
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DOG',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _breedList();
                          });
                    },
                    child: TextFormField(
                      controller: _breedController,
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Breed'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please complete required field';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _listView(
                              fieldValue: 'Care',
                              list: _careList,
                              textController: _careController);
                          });
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _careController,
                      decoration: InputDecoration(labelText: 'Care'),
                      validator: (value) {
                        if (value.isEmpty) {
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    // keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: 6,
                    maxLength: 900,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please complete required field'; //'Please complete required field'
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    enabled: false,
                    minLines: 2,
                    maxLines: 4,
                    controller: _addressController,
                    maxLength: 500,
                    decoration: InputDecoration(
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please complete required field'; //'Please complete required field'
                      }
                      return null;
                    },
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: GalleryImage(
                      imageUrls: _catProvider.urlList,
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (BuildContext context){
                        return ImagePickerWidget();
                      });
                    },
                    child: Neumorphic(
                      child: Container(
                        height: 40,
                        child: Center(child: Text(_catProvider.urlList.length>0 ? 'Upload images' : 'Upload image'),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
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
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  validate(_catProvider);
                  print(_catProvider.dataToFirestore);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
