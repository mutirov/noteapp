import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/models/note.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class NewNoteController extends ChangeNotifier {
  Note? _note;
  set note(Note? value) {
    _note = value;
    _title = value?.title ?? '';
    _content = value?.content ?? '';
    _tags.addAll(value?.tags ?? []);
    notifyListeners();
  }

  Note? get note => _note;

  bool _readOnly = false;
  bool get readOnly => _readOnly;

  set readOnly(bool value) {
    if (_readOnly != value) {
      _readOnly = value;
      notifyListeners();
    }
  }

  String _title = '';
  String get title => _title.trim();
  set title(String value) {
    _title = value.trim();
    notifyListeners();
  }

  String _content = '';
  String get content => _content;

  void updateContent(String value) {
    _content = value;
    notifyListeners();
  }

  final List<String> _tags = [];
  List<String> get tags => [..._tags];
  void addTag(String value) {
    _tags.add(value);
    //  if (!_tags.contains(value)) _tags.add(value);
    notifyListeners();
  }

  void removeTag(int index) {
    _tags.removeAt(index);
    notifyListeners();
  }

  void updateTag(String tag, int index) {
    _tags[index] = tag;
    notifyListeners();
  }

  bool get isNewNote => _note == null;

  bool canSaveNote() {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = _content.trim().isNotEmpty
        ? _content.trim()
        : null;
    bool canSave = newTitle != null || newContent != null;
    if (!isNewNote) {
      canSave &=
          newTitle != _note?.title ||
          newContent != note?.content ||
          !const DeepCollectionEquality().equals(_tags, _note?.tags);
    }
    return canSave;
  }

  void saveNote(BuildContext context) {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = _content.trim().isNotEmpty
        ? _content.trim()
        : null;
    // final String contentJson = _document.toDelta().toJson().toString();
    final int now = DateTime.now().millisecondsSinceEpoch;
    final Note newNote = Note(
      title: newTitle,
      content: newContent,
      // contenJson: contentJson,
      createdAt: isNewNote ? now : _note!.createdAt,
      updatedAt: now,
      tags: _tags.isNotEmpty ? _tags : null,
    );
    final notesProvider = context.read<NotesProvider>();
    isNewNote
        ? notesProvider.addNote(newNote)
        : notesProvider.updateNote(newNote);
    Navigator.pop(context);
  }
}

