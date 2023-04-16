import 'package:flutter/material.dart';
import 'note.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NoteDetail extends StatefulWidget {
  final Function(Note) onSave;
  final Note? note;
  // NoteInput({required this.onSave});
  const NoteDetail({
    Key? key,
    this.note,
    required this.onSave,
  }) : super(key: key);

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  Color _noteColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note?.title ?? '';
    _contentController.text = widget.note?.content ?? '';
  }

  void _saveNote() {
    final String title = _titleController.text;
    final String content = _contentController.text;

    if (title.isNotEmpty) {
      final int id = widget.note?.id ?? DateTime.now().millisecondsSinceEpoch;
      final Note newNote = Note(
        id: id,
        title: title,
        content: content,
        dateTime: DateTime.now(),
        color: _noteColor.value.toString(),
      );
      widget.onSave(newNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Thêm ghi chú' : 'Chỉnh sửa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Chọn màu'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: _noteColor,
                            onColorChanged: (Color color) {
                              setState(() {
                                _noteColor = color;
                              });
                            },
                            showLabel: false,
                            pickerAreaHeightPercent: 0.78,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Đóng'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.color_lens),
              ),
              ElevatedButton(
                onPressed: _saveNote,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
