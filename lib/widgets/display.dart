import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class Display extends StatelessWidget {
  const Display({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: const Color(0xFF131419),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
                inset: true,
                blurRadius: 5),
            BoxShadow(
                color: Colors.white.withOpacity(0.12),
                offset: const Offset(-3, -3),
                inset: true,
                blurRadius: 7),
          ]),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Text(
          text.substring(0, text.length) + '|',
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
