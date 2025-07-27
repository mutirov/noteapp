import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/widgets/note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      clipBehavior: Clip.none, // to show the shadows
      itemCount: notes.length,
      itemBuilder: (context, int index) {
        return NoteCard(
          note: notes[index],
          isInGrid: false);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}