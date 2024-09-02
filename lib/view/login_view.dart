import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restapi_php/constants/linkapi.dart';
import 'package:restapi_php/services/crud.dart';
import 'package:restapi_php/validate.dart';
import 'package:restapi_php/view/home_view.dart';
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
    if (formstate.currentState!.validate()) {
      loading = true;
      setState(() {});
      var response = await Crud().postRespones(linklogin, {
        'email': email.text,
        'password': password.text,
      });
      loading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeView.id, (route) => false);
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
              Text("خطاء في تسجيل الدخول حاااول مرة اخرى",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ).show();
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
