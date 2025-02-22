import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/color_extention.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final IconData icon;
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  final List<TextInputFormatter>? inputFormat;
  const RoundTextField(
      {super.key,
      required this.hitText,
      required this.icon,
      this.controller,
      this.margin,
      this.keyboardType,
      this.obscureText = false,
      this.inputFormat,
      this.rigtIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: TColor.lightGray, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormat,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hitText,
            suffixIcon: rigtIcon,
            prefixIcon: Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                child: Icon(icon)),
            hintStyle: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}
