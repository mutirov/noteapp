import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:notes_app/tools/dialogs.dart';
import 'package:notes_app/widgets/note_icon_button_outlined.dart';
import 'package:notes_app/widgets/note_metadata.dart';
import 'package:provider/provider.dart';

class NewOrEditNotePage extends StatefulWidget {
  final bool? isNewNote;
  const NewOrEditNotePage({required this.isNewNote, super.key});

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final NewNoteController newNoteController;
  late final TextEditingController _titleController;
  late TextEditingController _controller = TextEditingController();

  late FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController(text: newNoteController.document.toPlainText());
    newNoteController = context.read<NewNoteController>();
    _titleController = TextEditingController(text: newNoteController.title);
    _controller = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isNewNote ?? true) {
        newNoteController.readOnly = false; // Set to false for new notes
        _focusNode.requestFocus();
      } else {
        newNoteController.readOnly =
            true; // Set to true for editing existing notes
           WidgetsBinding.instance.addPostFrameCallback((_) {
  if (widget.isNewNote ?? true) {
    newNoteController.readOnly = false;
    _focusNode.requestFocus();
  } else {
    newNoteController.readOnly = true;
    _controller.text = newNoteController.content;
  }
});

      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // late final QuillController _quillController;

  // @override
  // void initState() {
  //   _quillController = QuillController.basic();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _quillController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if(!newNoteController.canSaveNote()) {
          Navigator.pop(context);
          return;
        }
        final bool? shouldSave = await showConfirmatinDialog(context: context);
        if (shouldSave == null) return;
        if (!context.mounted) return;
        if (shouldSave) {
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text((widget.isNewNote ?? true) ? 'New Note' : 'Edit Note'),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoteIconButtonOutlined(
              icon: FontAwesomeIcons.chevronLeft,
              onPressed: () {
                //maybePop, geri gidilecek bir sayfa varsa geri gider, yoksa hiçbir şey yapmaz.
                Navigator.maybePop(context);
              },
            ),
          ),
          actions: [
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) =>
                  newNoteController.readOnly,
              builder: (context, readOnly, child) => NoteIconButtonOutlined(
                icon: readOnly
                    ? FontAwesomeIcons.pen
                    : FontAwesomeIcons.bookOpen,
                onPressed: () {
                  newNoteController.readOnly = !readOnly;
                  if (newNoteController.readOnly) {
                    FocusScope.of(context).unfocus();
                  } else {
                    _focusNode.requestFocus();
                  }
                },
              ),
            ),
            Selector<NewNoteController, bool>(
              selector: (_, newNoteController) =>
                  newNoteController.canSaveNote(),
              builder: (context, canSaveNote, child) => NoteIconButtonOutlined(
                icon: FontAwesomeIcons.check,
                onPressed: canSaveNote
                    ? () {
                        newNoteController.saveNote(context);
                      }
                    : null, // Disable if cannot save
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<NewNoteController, bool>(
                selector: (context, controller) => controller.readOnly,
                builder: (context, read, child) => TextField(
                  controller: _titleController,
                  //readOnly variaiable name not nessesary as the same as controller.readOnly,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Title here',
                    hintStyle: TextStyle(color: gray300),
                    border: InputBorder.none,
                  ),
                  //  canRequestFocus: !read, // Prevents focus if readOnly is true
                  onChanged: (newValue) {
                    newNoteController.title = newValue;
                  },
                ),
              ),
              NoteMetadata(note: newNoteController.note,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Selector<NewNoteController, bool>(
                    selector: (_, controller) => controller.readOnly,
                    builder: (_, read, _) => TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      readOnly: read,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintText: 'Write your note here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: gray300),
                        ),
                      ),
                      style: TextStyle(fontSize: 16, color: gray900),
                      onChanged: (newValue) {
                        newNoteController.updateContent(newValue);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
