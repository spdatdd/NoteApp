import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_manager.dart';
import 'note_card.dart';
import 'note_detail.dart';

class NoteHome extends StatefulWidget {
  const NoteHome({Key? key}) : super(key: key);

  @override
  State<NoteHome> createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {
  late NoteManager _noteManager;

  @override
  void initState() {
    super.initState();
    _noteManager = Provider.of<NoteManager>(context, listen: false);
    _noteManager.loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App'),
      ),
      body: Consumer<NoteManager>(
        builder: (context, noteManager, child) {
          return ListView.builder(
            itemCount: noteManager.notes.length,
            itemBuilder: (context, index) {
              final note = noteManager.notes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetail(
                        note: note,
                        onSave: (newNote) {
                          _noteManager.update(newNote);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
                child: NoteCard(note: note),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetail(
                onSave: (newNote) {
                  _noteManager.add(newNote);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
