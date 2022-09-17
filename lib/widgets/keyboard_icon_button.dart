import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class KeyboardIconButton extends StatelessWidget {
  const KeyboardIconButton(
      {Key? key, required this.icon, required this.isFocused})
      : super(key: key);
  final bool isFocused;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var buttonWidth = (size.width - 50 - (10 * 4)) / 4;
    var buttonHeight = (size.height - 150 - 20 - 50 - 100) / 5;
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF131419),
        borderRadius: BorderRadius.circular(5),
        boxShadow: isFocused
            ? [
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
              ]
            : [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 5),
                BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    offset: const Offset(-3, -3),
                    blurRadius: 7),
              ],
      ),
      child: Center(
        child: Icon(
          icon,
          color: isFocused ? const Color(0xFF7CFC00) : const Color(0xFFC7C7C7),
          size: isFocused ? 18 : 20,
        ),
      ),
    );
  }
}
