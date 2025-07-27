import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/widgets/note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({required this.notes, super.key});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none, // to show the shadows
      itemCount: notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // childAspectRatio: 1.0,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, int index) {
        return NoteCard(
          note: notes[index],
          isInGrid: true);
      },
    );
  }
}