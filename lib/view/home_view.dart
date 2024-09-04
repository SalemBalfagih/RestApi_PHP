import 'package:flutter/material.dart';
import 'package:restapi_php/constants/linkapi.dart';
import 'package:restapi_php/main.dart';
import 'package:restapi_php/model/notes_model.dart';
import 'package:restapi_php/services/crud.dart';
import 'package:restapi_php/view/add_note_view.dart';
import 'package:restapi_php/view/login_view.dart';
import 'package:restapi_php/widgets/custom_card.dart';
import 'package:restapi_php/widgets/custom_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  State<HomeView> createState() => _HomeViewState();
}

getNotes() async {
  var response = await Crud().postRespones(linkview, {
    "id": sharedPreferences.getString("id"),
  });
  return response;
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
        onPressed: () {
          Navigator.of(context).pushNamed(AddNotes.id);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text("loading..."));
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail') {
                      return const Center(child: Text("no data"));
                    } else {
                      return Expanded(
                        child: CustomListView(
                          snapshot: snapshot,
                        ),
                      );
                    }
                  }
                  return const Center(child: Text(r"loading...$$f"));
                })
          ],
        ),
      ),
    );
  }
}
