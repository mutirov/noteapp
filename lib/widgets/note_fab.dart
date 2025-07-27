import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/tools/constants.dart';

class NoteFab extends StatelessWidget {
  const NoteFab({
    super.key,
    required this.onPressed,
  });
   final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: black,
           //blurRadius: 12,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: FloatingActionButton.large(
        onPressed: onPressed,
        backgroundColor: primary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: black),
        ),
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}