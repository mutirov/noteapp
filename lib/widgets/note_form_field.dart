import 'package:flutter/material.dart';
import 'package:notes_app/tools/constants.dart';

class NoteFormField extends StatelessWidget {
  const NoteFormField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.autofocus = false,
    this.filled,
    this.fillColor,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.keyboardType,
  });
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool autofocus;
  final bool? filled;
  final Color? fillColor;
  final String? labelText;
  final Widget? suffixIcon;
  final bool obscureText; 
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      validator: validator,
      key: key,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
        filled: filled,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: primary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      obscureText: obscureText,
      textCapitalization: textCapitalization, // Buyuk harf ile baslar
      textInputAction: textInputAction,
      keyboardType: keyboardType,
    );
  }
}
