import 'package:flutter/material.dart';
import 'package:pet_adoption/forms/forms_screen.dart';
import 'package:pet_adoption/forms/seller_pet_form.dart';
import 'package:pet_adoption/forms/user_review_screen.dart';
import 'package:pet_adoption/provider/cat_provider.dart';
import 'package:pet_adoption/provider/product_provider.dart';
import 'package:pet_adoption/screens/authentication/email_auth_screen.dart';
import 'package:pet_adoption/screens/authentication/email_verification_screen.dart';
import 'package:pet_adoption/screens/authentication/phoneauth_screen.dart';
import 'package:pet_adoption/screens/authentication/reset_password_screen.dart';
import 'package:pet_adoption/screens/categories/category_list.dart';
import 'package:pet_adoption/screens/categories/subCat_screen.dart';
import 'package:pet_adoption/screens/home_screen.dart';
import 'package:pet_adoption/screens/location_screen.dart';
import 'package:pet_adoption/screens/login_screen.dart';
import 'package:pet_adoption/screens/main_screen.dart';
import 'package:pet_adoption/screens/product_details_screen.dart';
import 'package:pet_adoption/screens/product_by_category_screen.dart';
import 'package:pet_adoption/screens/sellitems/seller_category_list.dart';
import 'package:pet_adoption/screens/sellitems/seller_subCat.dart';
import 'package:pet_adoption/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(
      MultiProvider(
        providers: [
          Provider (create: (_) => CategoryProvider()),
          Provider (create: (_) => ProductProvider()),
        ],
        child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan.shade900,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
        LocationScreen.id: (context) => LocationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        EmailAuthScreen.id: (context) => EmailAuthScreen(),
        EmailVerificationScreen.id: (context) => EmailVerificationScreen(),
        PasswordResetScreen.id: (context) => PasswordResetScreen(),
        CategoryListScreen.id: (context) => CategoryListScreen(),
        SubCatList.id: (context) => SubCatList(),
        MainScreen.id: (context) => MainScreen(),
        SellerSubCatList.id: (context) => SellerSubCatList(),
        SellerCategory.id: (context) => SellerCategory(),
        SellerPetForm.id: (context) => SellerPetForm(),
        UserReviewScreen.id: (context) => UserReviewScreen(),
        FormsScreen.id: (context) => FormsScreen(),
        ProductDetailsScreen.id: (context) => ProductDetailsScreen(),
        ProductByCategory.id: (context) => ProductByCategory(),
      },
    );
  }
}
