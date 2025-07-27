import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/new_or_edit_note_page.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:notes_app/tools/dialogs.dart';
import 'package:notes_app/tools/utils.dart';
import 'package:notes_app/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.isInGrid, super.key, required this.note});
  final bool isInGrid;
  final Note note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => NewNoteController()..note = note,
              child: const NewOrEditNotePage(isNewNote: false),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: primary.withOpacity(0.5),
              // blurRadius: 4.0,
              offset: Offset(4, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.title != null) ...[
              Text(
                note.title!,
                maxLines: 1,
                overflow: TextOverflow
                    .ellipsis, //this will add "..." end of the text if it overflows
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: gray900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4.0),
            ],
            if (note.tags != null) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      note.tags!.length,
                      (index) => NoteTag(label: note.tags![index]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
            ],
            if (note.content != null)
              (isInGrid)
                  ? Text(
                    note.content!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: gray700, fontSize: 14),
                  )
                  : Text(
                      note.content!,
                      style: TextStyle(color: gray700, fontSize: 14),
                    ),
           Divider(),
            Row(
              children: [
                Text(
                  formatNoteDate(note.createdAt),
                  style: TextStyle(
                    color: gray500,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
             Divider(),
                GestureDetector(
                  onTap: () async {
                    final shouldDelete =
                        await showConfirmatinDialog(context: context) ?? false;
                    if (shouldDelete && context.mounted) {
                      context.read<NotesProvider>().deleteNote(
                        // Provider.of<NewNoteController>(context, listen: false)
                        note,
                      );
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    size: 16,
                    color: gray500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
