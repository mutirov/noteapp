import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/tools/constants.dart';

class NoteIconButton extends StatelessWidget {
  const NoteIconButton({super.key,this.iconSize, required this.icon, this.onPressed,});

  final double? iconSize;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(icon),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(),
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      iconSize: iconSize,
      color: gray700,
    );
  }
}
