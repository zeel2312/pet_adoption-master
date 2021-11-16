import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:pet_adoption/forms/user_review_screen.dart';
import 'package:pet_adoption/provider/cat_provider.dart';
import 'package:pet_adoption/services/firebase_services.dart';
import 'package:pet_adoption/widgets/imagePicker_widget.dart';
import 'package:provider/provider.dart';

class SellerPetForm extends StatefulWidget {
  static const String id = 'pet-form';

  @override
  _SellerPetFormState createState() => _SellerPetFormState();
}

class _SellerPetFormState extends State<SellerPetForm> {
  final _formKey = GlobalKey<FormState>();

  FirebaseService _service = FirebaseService();

  var _breedController = TextEditingController();
  var _careController = TextEditingController();

  // var _ageController = TextEditingController();
  var _descriptionController = TextEditingController();

  validate(CategoryProvider provider) {
    if (_formKey.currentState.validate()) {
      if (provider.urlList.isNotEmpty) {
        provider.dataToFirestore.addAll({
          'category': provider.selectedCategory,
          'subCat': provider.selectedSubCat,
          'breed': _breedController.text,
          'care': _careController.text,
          'description': _descriptionController.text,
          'sellerUid': _service.user.uid,
          'images': provider.urlList,
          'postedAt' : DateTime.now().microsecondsSinceEpoch,
        });

        print(provider.dataToFirestore);

        Navigator.pushNamed(context, UserReviewScreen.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image not uploaded'),
          ),
        );
      }
    } else {
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
  void didChangeDependencies() {
    var _catProvider = Provider.of<CategoryProvider>(context);

    setState(() {
      _breedController.text = _catProvider.dataToFirestore.isEmpty
          ? null
          : _catProvider.dataToFirestore['breed'];
      _careController.text = _catProvider.dataToFirestore.isEmpty
          ? null
          : _catProvider.dataToFirestore['care'];
      _descriptionController.text = _catProvider.dataToFirestore.isEmpty
          ? null
          : _catProvider.dataToFirestore['description'];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var _provider = Provider.of<CategoryProvider>(context);
    var _catProvider = Provider.of<CategoryProvider>(context);

    Widget _appBar(title, fieldValue) {
      return AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
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
                    '${_catProvider.selectedCategory}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  SizedBox(
                    height: 10,
                  ),
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

                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: _catProvider.urlList.length == 0
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'No image selected',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : GalleryImage(
                            imageUrls: _catProvider.urlList,
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ImagePickerWidget();
                          });
                    },
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          color: Theme.of(context).primaryColor),
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            _catProvider.urlList.length > 0
                                ? 'Upload images'
                                : 'Upload image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
                    'Next',
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
