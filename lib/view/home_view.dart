import 'package:flutter/material.dart';
import 'package:restapi_php/main.dart';
import 'package:restapi_php/view/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              sharedPreferences.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(LoginView.id, (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        title: const Text(
          "Home",
        ),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
