import 'package:flutter/material.dart';
import 'package:notes_app/widgets/confirmation_dialog.dart';
import 'package:notes_app/widgets/dialog_card.dart';
import 'package:notes_app/widgets/new_tag_dialog.dart';

Future<String?> showNewTagDialog({required BuildContext context, String? tag}) {
  return showDialog(
    context: context,
    builder: (context) {
      return DialogCard(child: NewTagDialog(tag: tag));
    },
  );
}

Future<bool?> showConfirmatinDialog({required BuildContext context}) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => DialogCard(child: ConfirmationDialog()),
  );
}
