import 'package:flutter/material.dart';
import 'package:restapi_php/view/login_view.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({super.key});
  static const String id = "SuccessView";
  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "تم انشاء الحساب الرجاء تسجيل الدخول",
              style: TextStyle(fontSize: 25),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(LoginView.id, (route) => false);
              },
              color: Colors.green,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              child: const Text("تسجيل الدخول"),
            ),
          ],
        ),
      ),
    );
  }
}
