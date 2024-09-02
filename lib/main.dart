import 'package:flutter/material.dart';
import 'package:restapi_php/view/home_view.dart';
import 'package:restapi_php/view/login_view.dart';
import 'package:restapi_php/view/singup_view.dart';
import 'package:restapi_php/view/success_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "API",
      initialRoute: LoginView.id,
      routes: {
        LoginView.id: (context) => const LoginView(),
        SingupView.id: (context) => const SingupView(),
        HomeView.id: (context) => const HomeView(),

        SuccessView.id: (context) => const SuccessView(),
        // "addnotes": (context) => const AddNotes(),
      },
    );
  }
}
