import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restapi_php/constants/linkapi.dart';
import 'package:restapi_php/main.dart';
import 'package:restapi_php/services/crud.dart';
import 'package:restapi_php/validate.dart';
import 'package:restapi_php/view/home_view.dart';
import 'package:restapi_php/widgets/custom_text_filed.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});
  static String id = 'AddNotes';
  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool isloading = false;

  addnotes() async {
    if (formState.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await Crud().postRespones(
        linkadd,
        {
          "title": title.text,
          "content": content.text,
          "userid": sharedPreferences.getString("id"),
        },
      );
      isloading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeView.id, (route) => false);
      }
    } else {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          dialogBackgroundColor: Colors.green,
          showCloseIcon: true,
          body: const Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("خطاء  حاااول مرة اخرى",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(
                height: 20,
              ),
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formState,
                child: ListView(
                  children: [
                    CustomTextFiled(
                        hint: "title",
                        mycontroller: title,
                        validato: (val) {
                          return validatoInput(val!, 24, 4);
                        }),
                    CustomTextFiled(
                        hint: "content",
                        mycontroller: content,
                        validato: (val) {
                          return validatoInput(val!, 224, 4);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await addnotes();
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 100),
                      child: const Text("addnote"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
