import 'package:flutter/material.dart';
class CustomTextButton extends StatelessWidget {
  const CustomTextButton({Key? key, this.onPressed, required this.text}) : super(key: key);
  final Function()? onPressed ;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child:  Text(
        text.toUpperCase(),
         style: const TextStyle(fontSize: 17),
      ),
    );
  }
}
