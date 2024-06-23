import 'package:flutter/material.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/note_card.dart';
import 'package:mindmap2/notes_grid.dart';
import 'package:mindmap2/provider/note_provider.dart';
import 'package:mindmap2/widget/child_note_card.dart';
import 'package:mindmap2/widget/note_card_container.dart';
import 'package:mindmap2/widget/note_detail_overlay.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}


class _NotesPageState extends State<NotesPage>{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<NoteProvider>(context, listen: false).fetchNotesAndRelationsFromFB();
    });
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void _addNote (BuildContext context) {
    final title = titleController.text;
    final content = contentController.text;
    if (title.isNotEmpty && content.isNotEmpty) {
      final newNote = Note(
        id:DateTime.now().toString(),
        title: title,
        content: content,
      );

      Provider.of<NoteProvider>(context, listen: false).addNoteToFirebase(newNote);

      titleController.clear();
      contentController.clear();
    }
  }

  @override
  Widget build(BuildContext context){
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child) {
        List<NoteCardContainer> noteList = [];
        for (var note in noteProvider.notes) {
          noteList.add(NoteCardContainer(note: note, noteProvider: noteProvider,));
        }
        List<ChildNoteCard> childNoteCardList  = [];
        if (noteProvider.selectedNote != null) {
          List<Note> childNoteList = noteProvider.getChildNotes(noteProvider.selectedNote!.id);
          for (var childNote in childNoteList) {
            childNoteCardList.add(ChildNoteCard(note: childNote, noteProvider: noteProvider));
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('tektoApp'),
          ),
          body: Stack(
            children: [
              Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: contentController,
                        decoration: InputDecoration(labelText: 'Content'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _addNote(context),
                      child: Text('Add Note'),
                    ),
                    Expanded(
                      child: NotesGrid(noteList: noteList)
                    )
                  ]
              ),
              if (noteProvider.selectedNote != null)
                Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      child: NoteDetailOverlay(
                        note: noteProvider.selectedNote!,
                        childNoteCardList: childNoteCardList,
                      ),
                    )
                )
            ],
          ),
        );
      }
    );
  }
}