import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:notes_app/tools/dialogs.dart';
import 'package:notes_app/tools/utils.dart';
import 'package:notes_app/widgets/note_icon_button.dart';
import 'package:notes_app/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NoteMetadata extends StatefulWidget {
  const NoteMetadata({super.key, required this.note});
  final Note? note;

  @override
  State<NoteMetadata> createState() => _NoteMetdataState();
}

class _NoteMetdataState extends State<NoteMetadata> {
    NewNoteController? newNoteController;

  @override
  void initState() {
    super.initState();
    newNoteController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!(widget.note != null)) ...[
          //! operatörü, "değil" (not) anlamına gelir. Yani tersini alır.
          // widget.isNewNote ?? true
          // Bu ifade şunu demek:
          // Eğer widget.isNewNote null değilse, kendi değerini al.
          // Eğer null ise, true kabul et.
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Last modified:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  formatNoteDate(newNoteController?.note?.updatedAt ?? DateTime.now().millisecondsSinceEpoch),
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Created:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                formatNoteDate(newNoteController?.note?.createdAt ?? DateTime.now().millisecondsSinceEpoch),
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
                ),
              ),
            ],
          ),
        ],
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Text(
                    'Tags',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: gray500,
                    ),
                  ),
                  SizedBox(width: 8),
                  NoteIconButton(
                    iconSize: 20,
                    icon: FontAwesomeIcons.circlePlus,
                    onPressed: () async {
                      final String? tag = await showNewTagDialog(context:context);
                      if (tag != null) {
                        newNoteController?.addTag(tag);
                      }
                      //  print('New tag: $tag');
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Selector<NewNoteController, List<String>>(
                selector: (context, newNoteController) =>
                    newNoteController.tags,
                builder: (context, tags, child) => tags.isEmpty
                    ? Text(
                        'No tags added',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            tags.length,
                            (index) => NoteTag(
                              onTap: () async {
                               final String? tag = await showNewTagDialog(context: context, tag: tags[index]);

                               if(tag !=null && tag != tags[index]) {
                                newNoteController?.updateTag(tag, index);
                               }
                              },
                              label: tags[index],
                              onClosed: () {
                                context.read<NewNoteController>().removeTag(
                                  index,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(color: gray700, thickness: 2),
        ),
      ],
    );
  }
}
