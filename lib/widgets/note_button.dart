import 'package:flutter/material.dart';
import 'package:notes_app/tools/constants.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({super.key, required this.child, this.onPressed, this.isOutlined = false});

  final Widget child;
  final VoidCallback? onPressed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: isOutlined ? primary : Colors.black, offset: Offset(2, 2))],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.white : primary,
          foregroundColor: isOutlined ?primary : Colors.white,
          disabledBackgroundColor: gray300,
          disabledForegroundColor: black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: isOutlined ? primary : black),
          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),

        child: child,
      ),
    );
  }
}
