import 'package:flutter/material.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:notes_app/widgets/note_button.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Add a tag',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8),
        TextFormField(
          autofocus: true,
          validator: (value){
            if(value!.trim().isEmpty){
              return 'Please enter a tag name';
            }else if(value.trim().length > 16){
              return 'Tag name should not exceed 16 characters';
            }
            return null;
          },
          key: _tagKey,
          onChanged: (newValue) {
            _tagKey.currentState?.validate();
          },
          controller: _tagController,
          decoration: InputDecoration(
            hintText: 'Enter tag name',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            isDense: true,
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
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: NoteButton(label: 'Add', onPressed: () {
              if (_tagKey.currentState!.validate()) {
                Navigator.pop(context, _tagController.text.trim());
              }
            },),
          ),
       ] );
  }
}