import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final NotesProvider _notesProvider;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _notesProvider = context.read();
    _searchController = TextEditingController()
      ..addListener(() {
        _notesProvider.searchNotes = _searchController.text;
      });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (newValue) {
        _notesProvider.searchNotes = newValue;
      },
      decoration: InputDecoration(
        hintText: 'Search notes...',
        hintStyle: TextStyle(fontSize: 14),
        prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
        suffixIcon: ListenableBuilder(
          listenable: _searchController,
          builder: (context, clearButton) =>
              _searchController.text.isNotEmpty ? clearButton! : SizedBox.shrink(),
          child: GestureDetector(
// performansli olur cunku ListenableBuilder her seferinde yeniden rebuild edildiginde child rebuild edilmez            
            onTap: () {
              _searchController.clear();
            },
            child: const Icon(FontAwesomeIcons.xmark, size: 16),
          ),
        ),
        fillColor: white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: primary),
        ),
      ),
    );
  }
}
