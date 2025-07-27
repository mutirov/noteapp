import 'package:flutter/material.dart';
import 'package:notes_app/tools/constants.dart';

class DialogCard extends StatelessWidget {
  const DialogCard({
    super.key,
    required this.child
  });
final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width:
              MediaQuery.of(context).size.width * 0.8,
            margin: MediaQuery.of(context).viewInsets,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: black),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child:child,
        ),
      ),
    );
  }
}
