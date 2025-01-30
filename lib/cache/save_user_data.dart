import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

Future<void> saveLoginData(LoginResponse loginResponse) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('accessToken', loginResponse.accessToken ?? '');
  await prefs.setString('refreshToken', loginResponse.refreshToken ?? '');
  await prefs.setInt('id', loginResponse.id ?? 0);
  await prefs.setString('username', loginResponse.username ?? '');
  await prefs.setString('email', loginResponse.email ?? '');
  await prefs.setString('firstName', loginResponse.firstName ?? '');
  await prefs.setString('lastName', loginResponse.lastName ?? '');
  await prefs.setString('gender', loginResponse.gender ?? '');
  await prefs.setString('image', loginResponse.image ?? '');

  print("Login data saved to SharedPreferences.");
}

Future<LoginResponse?> getLoginData() async {
  final prefs = await SharedPreferences.getInstance();

  final accessToken = prefs.getString('accessToken');
  if (accessToken == null || accessToken.isEmpty) {
    return null;
  }

  return LoginResponse(
    accessToken: accessToken,
    refreshToken: prefs.getString('refreshToken'),
    id: prefs.getInt('id'),
    username: prefs.getString('username'),
    email: prefs.getString('email'),
    firstName: prefs.getString('firstName'),
    lastName: prefs.getString('lastName'),
    gender: prefs.getString('gender'),
    image: prefs.getString('image'),
  );
}

void checkLoginStatus() async {
  final loginData = await getLoginData();
  if (loginData != null) {
    print('User is logged in: ${loginData.username}');
  } else {
    print('User is not logged in');
  }
}
Future<void> clearLoginData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  print("Login data cleared from SharedPreferences.");
}
