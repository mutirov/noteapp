import 'package:flutter/material.dart';
import 'package:notes_app/widgets/dialog_card.dart';
import 'package:notes_app/widgets/note_button.dart';
import 'package:notes_app/widgets/note_form_field.dart';

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({super.key, this.tag});
  final String? tag;

  @override
  State<NewTagDialog> createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  late final TextEditingController _tagController;
  late final GlobalKey<FormFieldState> _tagKey;

  @override
  void initState() {
    super.initState();
    _tagController = TextEditingController(text: widget.tag);
    _tagKey = GlobalKey<FormFieldState>();
  }

  @override
  void dispose() {
    _tagController.dispose();
    _tagKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add a tag',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 8),
          NoteFormField(
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Please enter a tag name';
              } else if (value.trim().length > 16) {
                return 'Tag name should not exceed 16 characters';
              }
              return null;
            },
            onChanged: (newValue) {
              _tagKey.currentState?.validate();
            },
            key: _tagKey,
            hintText: 'Enter tag name',
            controller: _tagController,
            autofocus: true,
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: NoteButton(
              child: Text('Add'),
              onPressed: () {
                if (_tagKey.currentState!.validate()) {
                  Navigator.pop(context, _tagController.text.trim());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

