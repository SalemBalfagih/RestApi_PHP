import 'package:flutter/material.dart';
import 'package:restapi_php/constants/linkapi.dart';
import 'package:restapi_php/main.dart';
import 'package:restapi_php/model/notes_model.dart';
import 'package:restapi_php/services/crud.dart';
import 'package:restapi_php/view/edit_note_view.dart';
import 'package:restapi_php/view/home_view.dart';
import 'package:restapi_php/widgets/custom_card.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({
    super.key,
  });

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  bool isloading = false;

  getNotes() async {
    var response = await Crud().postRespones(linkview, {
      "id": sharedPreferences.getString("id"),
    });
    return response;
  }

  deleteNote(String id) async {
    isloading = true;
    setState(() {});
    var response = await Crud().postRespones(linkdelete, {
      'id': id,
    });
    if (response["status"] == "success") {
      isloading = true;
      setState(() {});
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeView.id, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                  child: ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, i) {
                        return CustomCard(
                            onPressed: () {
                              deleteNote(snapshot.data['data'][i]['notes_id']
                                  .toString());
                            },
                            ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditNoteView(
                                    notes: snapshot.data['data'][i]),
                              ));
                            },
                            model:
                                NotesModel.fromJson(snapshot.data['data'][i]));
                      }));
            }
          }
          return const Center(child: Text(r"loading...$$f"));
        });
  }
}
