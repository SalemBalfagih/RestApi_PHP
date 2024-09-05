import 'package:flutter/material.dart';
import 'package:restapi_php/constants/linkapi.dart';
import 'package:restapi_php/main.dart';
import 'package:restapi_php/model/notes_model.dart';
import 'package:restapi_php/services/crud.dart';
import 'package:restapi_php/view/add_note_view.dart';
import 'package:restapi_php/view/edit_note_view.dart';
import 'package:restapi_php/view/login_view.dart';
import 'package:restapi_php/widgets/custom_card.dart';
import 'package:restapi_php/widgets/custom_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
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
          onPressed: () {
            Navigator.of(context).pushNamed(AddNotes.id);
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
        body: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [CustomListView()])));
  }
}
