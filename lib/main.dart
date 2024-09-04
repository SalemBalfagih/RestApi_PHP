import 'package:flutter/material.dart';
import 'package:restapi_php/view/add_note_view.dart';
import 'package:restapi_php/view/home_view.dart';
import 'package:restapi_php/view/login_view.dart';
import 'package:restapi_php/view/singup_view.dart';
import 'package:restapi_php/view/success_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "API",
      initialRoute: sharedPreferences.getString('id') == null
          ? LoginView.id
          : HomeView.id,
      routes: {
        LoginView.id: (context) => const LoginView(),
        SingupView.id: (context) => const SingupView(),
        HomeView.id: (context) => const HomeView(),
        SuccessView.id: (context) => const SuccessView(),
        AddNotes.id: (context) => const AddNotes(),
      },
    );
  }
}
