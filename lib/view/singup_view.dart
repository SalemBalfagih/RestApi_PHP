import 'package:flutter/material.dart';
import 'package:restapi_php/constants/images.dart';
import 'package:restapi_php/constants/linkapi.dart';
import 'package:restapi_php/services/api.dart';
import 'package:restapi_php/validate.dart';
import 'package:restapi_php/view/login_view.dart';
import 'package:restapi_php/view/success_view.dart';
import 'package:restapi_php/widgets/custom_button.dart';
import 'package:restapi_php/widgets/custom_text_filed.dart';

class SingupView extends StatefulWidget {
  const SingupView({super.key});
  static String id = 'SingupView';
  @override
  State<SingupView> createState() => _SingupViewState();
}

class _SingupViewState extends State<SingupView> {
  bool loading = false;

  TextEditingController username = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();

  singUp() async {
    if (formstate.currentState!.validate()) {
      loading = true;
      setState(() {});
      Map<String, dynamic> response = await Api().postRespones(linksingup, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SuccessView.id, (route) => false);
      } else {
        print("sing up error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Form(
                      key: formstate,
                      child: Column(
                        children: [
                          Image.asset(
                            noteImage,
                            width: 200,
                            height: 200,
                          ),
                          CustomTextFiled(
                            validato: (val) {
                              return validatoInput(val!, 20, 10);
                            },
                            hint: "username",
                            mycontroller: username,
                          ),
                          CustomTextFiled(
                            validato: (val) {
                              return validatoInput(val!, 20, 4);
                            },
                            hint: "email",
                            mycontroller: email,
                          ),
                          CustomTextFiled(
                            validato: (val) {
                              return validatoInput(val!, 15, 4);
                            },
                            hint: "password",
                            mycontroller: password,
                          ),
                          CustomButton(
                            onPressed: () async {
                              await singUp();
                            },
                            text: "singUp",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: const Text("login ->"),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginView.id);
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
    );
  }
}
