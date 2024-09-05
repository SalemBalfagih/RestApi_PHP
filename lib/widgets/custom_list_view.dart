import 'package:flutter/material.dart';
import 'package:restapi_php/model/notes_model.dart';
import 'package:restapi_php/view/edit_note_view.dart';
import 'package:restapi_php/widgets/custom_card.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot<dynamic> snapshot;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: snapshot.data['data'].length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return CustomCard(
              onPressed: () async {},
              ontap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      EditNoteView(notes: snapshot.data['data'][i]),
                ));
              },
              model: NotesModel.fromJson(snapshot.data['data'][i]));
        });
  }
}
