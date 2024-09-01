import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.green,
      textColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
      child: Text(text),
    );
  }
}
