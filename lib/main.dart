import 'package:app_receitas/View/HomeView/MapView.dart';
import 'package:app_receitas/View/LoginView.dart';
import 'package:app_receitas/View/SignUpView.dart';
import 'package:app_receitas/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../View/HomeView/Home_Screen.dart';
import '../View/MealDetails_Screen.dart';
import '../View/SplashView/Splash_Screen.dart';
import 'package:dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final bool userLoggedIn = await _checkUserLoggedIn();

  runApp(MyApp(userLoggedIn: userLoggedIn));
}

Future<bool> _checkUserLoggedIn() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  return user != null;
}

class MyApp extends StatelessWidget {
  final bool userLoggedIn;

  const MyApp({Key? key, required this.userLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'lato'),
      debugShowCheckedModeBanner: false,
      initialRoute: userLoggedIn ? '/splash' : '/login',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/register', page: () => SignUpView()),
        GetPage(name: '/endereco', page: () => MapScreen())
      ],
    );
  }
}
