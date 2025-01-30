import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snapshop/cache/save_user_data.dart';
import 'package:snapshop/firebase_options.dart';
import 'package:snapshop/screens/splash_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final bool isLoggedIn = await checkLoginStatus();
  await Firebase.initializeApp();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn ? HomeScreen() : SplashScreen(),
    );
  }
}

Future<bool> checkLoginStatus() async {
  final loginData = await getLoginData();
  return loginData != null;
}
