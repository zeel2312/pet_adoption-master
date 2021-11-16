import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pet_adoption/provider/cat_provider.dart';
import 'package:pet_adoption/screens/location_screen.dart';
import 'package:pet_adoption/screens/main_screen.dart';
import 'package:pet_adoption/services/firebase_services.dart';
import 'package:provider/provider.dart';

class UserReviewScreen extends StatefulWidget {
  static const String id = 'user-review-screen';

  @override
  _UserReviewScreenState createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  FirebaseService _service = FirebaseService();

  var _nameController = TextEditingController();
  var _countryCodeController = TextEditingController(text: '+91');
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _addressController = TextEditingController();

  Future<void> updateUser(provider, Map<String, dynamic> data, context) {
    return _service.users.doc(_service.user.uid).update(data).then(
      (value) {
        saveProductToDb(provider, context);
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update location'),
        ),
      );
    });
  }

  Future<void> saveProductToDb(CategoryProvider provider, context) {
    return _service.products.add(provider.dataToFirestore).then(
      (value) {
        provider.clearData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'We have received your data and will be notified once get approved'),
          ),
        );
        Navigator.pushReplacementNamed(context, MainScreen.id);
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update location'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CategoryProvider>(context);

    showConfirmDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Are you sure, you want to save below pet'),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading:
                          Image.network(_provider.dataToFirestore['images'][0]),
                      title: Text(
                        _provider.dataToFirestore['breed'],
                        maxLines: 1,
                      ),
                      subtitle: Text(_provider.dataToFirestore['category']),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        NeumorphicButton(
                          onPressed: () {
                            setState(() {
                              _loading = false;
                            });
                            Navigator.pop(context);
                          },
                          style: NeumorphicStyle(
                            border: NeumorphicBorder(
                                color: Theme.of(context).primaryColor),
                            color: Colors.transparent,
                          ),
                          child: Text('Cancel'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        NeumorphicButton(
                          style: NeumorphicStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            updateUser(
                                    _provider,
                                    {
                                      'contactDetails': {
                                        'contactMobile': _phoneController.text,
                                        'contactEmail': _emailController.text,
                                        //address will be updated from address screen
                                      },
                                      'name': _nameController.text,
                                    },
                                    context)
                                .then((value) {
                              setState(() {
                                _loading = false;
                              });
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_loading)
                      Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      )),
                  ],
                ),
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
          'Review your details',
          style: TextStyle(color: Colors.black),
        ),
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot>(
          future: _service.getUserData(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              );
            }

            _nameController.text = snapshot.data['name'];
            _phoneController.text = snapshot.data['mobile'];
            _emailController.text = snapshot.data['email'];
            _addressController.text = snapshot.data['address'];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 40,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue.shade50,
                            radius: 38,
                            child: Icon(
                              CupertinoIcons.person_alt,
                              color: Colors.red.shade300,
                              size: 60,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(labelText: 'Your Name'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter your name';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Contact Details',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _countryCodeController,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Country',
                              helperText: 'Country Code',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Mobile number',
                              helperText: 'Enter your 10 Digit mobile number',
                            ),
                            maxLength: 10,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter mobile number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        final bool isValid =
                            EmailValidator.validate(_emailController.text);
                        if (value == null || value.isEmpty) {
                          return 'Enter Email';
                        }
                        if (value.isNotEmpty && isValid == false) {
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            minLines: 1,
                            maxLines: 6,
                            controller: _addressController,
                            maxLength: 500,
                            decoration: InputDecoration(
                              labelText: 'Address',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LocationScreen(
                                  popScreen: UserReviewScreen.id,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    return showConfirmDialog();
                  }
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('Enter required fields'),
                  //     ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
