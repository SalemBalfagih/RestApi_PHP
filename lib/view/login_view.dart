import 'package:flutter/material.dart';
import 'package:restapi_php/validate.dart';
import 'package:restapi_php/view/singup_view.dart';
import 'package:restapi_php/widgets/coustom_button.dart';
import 'package:restapi_php/widgets/custom_text_filed.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LoginView';
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool loading = false;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  login() async {
    if (formstate.currentState!.validate()) {}
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
                            "images/icons8_file_256.png",
                            width: 200,
                            height: 200,
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
                              return validatoInput(val!, 20, 4);
                            },
                            hint: "password",
                            mycontroller: password,
                          ),
                          CustomButton(
                            onPressed: () {
                              login();
                            },
                            text: "login",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: const Text("singup ->"),
                            onTap: () {
                              Navigator.of(context).pushNamed(SingupView.id);
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
