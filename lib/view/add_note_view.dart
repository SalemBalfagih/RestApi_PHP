import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restapi_php/constants/linkapi.dart';
import 'package:restapi_php/main.dart';
import 'package:restapi_php/services/api.dart';
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
  File? myfile;
  addnotes() async {
    if (myfile == null) {
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("الرجاء ا=ضافة صورة"))
        ..show();
    }
    if (formState.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await Api().postResponesWithFile(
          linkadd,
          {
            "title": title.text,
            "content": content.text,
            "userid": sharedPreferences.getString("id"),
          },
          myfile!);
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
                    MaterialButton(
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    XFile? xFile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (xFile != null) {
                                      myfile = File(xFile.path);
                                      Navigator.pop(context);
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: const Text(
                                        " add image from gallery",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                ),
                                InkWell(
                                  onTap: () async {
                                    XFile? xFile = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    if (xFile != null) {
                                      myfile = File(xFile.path);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: const Text(
                                        " add image from camare",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      color: myfile == null ? Colors.green : Colors.amber,
                      textColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 100),
                      child: const Text("addimage"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
