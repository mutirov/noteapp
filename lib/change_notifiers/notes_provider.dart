import 'package:flutter/material.dart';
import 'package:notes_app/enums/order_option.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/tools/extensions.dart';




class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  List<Note> get notes =>
      [..._searchNotes.isEmpty ? _notes : _notes.where(_test)]..sort(_compare);

  bool _test(Note note) {
    final search = searchNotes.trim().toLowerCase();
    final title = (note.title ?? '').trim().toLowerCase();
    final content = (note.content ?? '').trim().toLowerCase();
    final tags = (note.tags ?? [])
        .map((tag) => tag.trim().toLowerCase())
        .toList();

    return title.contains(search) ||
        content.contains(search) ||
        tags.deepContains(search);
  }

  int _compare(Note note1, Note note2) {
    return _orderBy == OrderOption.updatedAt
        ? _isDescending
              ? note2.updatedAt.compareTo(note1.updatedAt)
              : note1.createdAt.compareTo(note2.createdAt)
        : isDescending
        ? note2.createdAt.compareTo(note1.createdAt)
        : note1.createdAt.compareTo(note2.createdAt);
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere((n) => n.createdAt == note.createdAt);
    if (index != -1) {
      _notes[index] = note;
      notifyListeners();
    }
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  OrderOption _orderBy = OrderOption.updatedAt;
  OrderOption get orderBy => _orderBy;
  set orderBy(OrderOption value) {
    _orderBy = value;
    notifyListeners();
  }

  bool _isDescending = true;
  bool get isDescending => _isDescending;
  set isDescending(bool value) {
    _isDescending = value;
    notifyListeners();
  }

  bool _isGrid = true;
  bool get isGrid => _isGrid;
  set isGrid(bool value) {
    _isGrid = value;
    notifyListeners();
  }

  String _searchNotes = '';
  String get searchNotes => _searchNotes;
  set searchNotes(String value) {
    _searchNotes = value;
    notifyListeners();
  }
}
