import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;
  final String? Function(String?)? validato;
  const CustomTextFiled(
      {super.key,
      required this.hint,
      required this.mycontroller,
      required this.validato});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: validato,
        controller: mycontroller,
        decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
      ),
    );
  }
}
