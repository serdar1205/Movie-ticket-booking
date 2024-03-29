import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final String text;
  const ToastWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
         color: const Color.fromRGBO(44, 218, 82, 0.2),
      ),
      child:  Text(text),
    );
  }
}
