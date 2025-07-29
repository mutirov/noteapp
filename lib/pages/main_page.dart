import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/new_or_edit_note_page.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/tools/dialogs.dart';
import 'package:notes_app/widgets/no_notes.dart';
import 'package:notes_app/widgets/note_fab.dart';
import 'package:notes_app/widgets/note_grid.dart';
import 'package:notes_app/widgets/note_icon_button_outlined.dart';
import 'package:notes_app/widgets/notes_list.dart';
import 'package:notes_app/widgets/search_field.dart';
import 'package:notes_app/widgets/view_options.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes 📒'),
        actions: [
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.rightFromBracket,
            onPressed: () async {
              final bool shouldLogout =
                  await showConfirmationDialog(
                    context: context,
                    title: 'Do you want to log out?',
                  ) ??
                  false;
              if (shouldLogout) AuthService.logout();
            },
          ),
        ],
      ),
      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => NewNoteController(),
                child: const NewOrEditNotePage(isNewNote: true),
              ),
            ),
          );
        },
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty && notesProvider.searchNotes.isEmpty
              ? const NoNotes()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SearchField(),
                      if (notes.isNotEmpty) ...[
                        ViewOptions(),
                        Expanded(
                          child: notesProvider.isGrid
                              ? NotesGrid(notes: notes)
                              : NotesList(notes: notes),
                        ),
                      ] else
                        Expanded(
                          child: Center(
                            child: Text(
                              ''
                              'No notes found for your search query.',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
