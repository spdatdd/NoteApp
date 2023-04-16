import 'package:flutter/foundation.dart';
import 'note.dart';
import 'note_service.dart';

class NoteManager extends ChangeNotifier {
  final _noteService = NoteService.instance;

  final _notes = <Note>[];
  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    final items = await _noteService.getNotes();
    _notes.clear();
    _notes.addAll(items);
    notifyListeners();
  }

  void add(Note note) {
    _noteService.addNotes(note);
    _notes.add(note);
    notifyListeners();
  }

  void update(Note note) {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _noteService.updateNote(note);
      _notes[index] = note;
      notifyListeners();
    }
  }

  void delete(Note note) {
    _notes.removeWhere((n) => n.id == note.id);
    _noteService.deleteNote(note.id);
    notifyListeners();
  }

  void deleteAll() {
    _notes.clear();
    _noteService.deleteAll();
    notifyListeners();
  }

  void deleteTable() {
    _notes.clear();
    _noteService.deleteTable();
    notifyListeners();
  }
}
