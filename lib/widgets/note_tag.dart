import 'package:flutter/material.dart';
import 'package:notes_app/tools/constants.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({
    super.key,
    required this.label,
    this.onClosed, this.onTap,
  });
  final String label;
  final VoidCallback? onClosed;
  final VoidCallback? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2.0),
        decoration: BoxDecoration(
          color: gray100,
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.only(right: 4.0),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: onClosed != null ? 14 : 12, color: gray700),
            ),
            if (onClosed != null) ...[
            GestureDetector(
              onTap: onClosed,
              child: Icon(
                Icons.close,
                size: 14,
                color: gray500,
              ),
            ),
          ],],
        ),
      ),
    );
  }
}
