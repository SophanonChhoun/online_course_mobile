import 'package:online_tutorial/repos/note_repose.dart';
import 'package:flutter/material.dart';
import 'package:online_tutorial/models/note.dart';

class NoteView extends StatefulWidget {
  final int lessonId;
  final NoteData preFetchedNote;
  final bool autoFocus;
  int noteId;
  VoidCallback onClose;

  NoteView(
      {this.lessonId,
      this.preFetchedNote,
      this.autoFocus = true,
      this.noteId,
      this.onClose});

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final _textFieldController = TextEditingController();
  final _noteRepo = NoteRepo();
  NoteData initialNote;

  _setInitialNote(NoteData note) {
    initialNote = note;
    setState(() {
      _textFieldController.value = TextEditingValue(
          text: note.data.content,
          selection: TextSelection.collapsed(offset: note.data.content.length));
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.preFetchedNote != null) {
      initialNote = widget.preFetchedNote;

      // Might need to setState here
      _textFieldController.text =
          initialNote.data == null ? "" : initialNote.data.content;
    } else {
      if (widget.noteId != null) {
        _noteRepo.get(widget.noteId).then(_setInitialNote);
      } else {
        _noteRepo.getByLessonId(widget.lessonId).then(_setInitialNote);
      }
    }
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            final _enteredContent = _textFieldController.text;

            if ((initialNote.data == null)) {
              if (_enteredContent.isNotEmpty) {
                print("Create");
                _noteRepo.create(
                    lessonId: widget.lessonId, content: _enteredContent);
              }
            } else {
              if (_enteredContent.isEmpty) {
                print("Delete");
                _noteRepo.delete(initialNote.data.id);
              } else if (_enteredContent.compareTo(initialNote.data.content) !=
                  0) {
                print("Update");
                _noteRepo.updateContent(
                    id: initialNote.data.id, content: _enteredContent);
              }
            }
            if (widget.onClose != null) {
              widget.onClose();
            }
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Notes",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: initialNote != null
          ? TextFormField(
              controller: _textFieldController,
              autofocus: widget.autoFocus,
              maxLines: null,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(top: 8, left: 24, bottom: 24, right: 24),
                  hintText: "Your notes start here..."),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
