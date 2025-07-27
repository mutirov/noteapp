import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/tools/constants.dart';

class NoteIconButtonOutlined extends StatelessWidget {
  const NoteIconButtonOutlined({
    required this.icon,
    required this.onPressed,
    super.key,
  });
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon),
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: black),
        ),
      ),
    );
  }
}