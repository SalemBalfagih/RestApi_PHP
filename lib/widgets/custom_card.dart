import 'package:flutter/material.dart';
import 'package:restapi_php/constants/images.dart';
import 'package:restapi_php/model/notes_model.dart';

class CustomCard extends StatelessWidget {
  final void Function()? ontap;
  final NotesModel model;

  final void Function()? onPressed;
  const CustomCard(
      {super.key,
      required this.ontap,
      required this.onPressed,
      required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  noteImage,
                  height: 100,
                  width: 100,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${model.noteTitle}"),
                  subtitle: Text("${model.noteContent}"),
                  trailing: IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.delete),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
