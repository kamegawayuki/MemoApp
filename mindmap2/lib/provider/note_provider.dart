
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mindmap2/model/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  Note? _selectedNote;

  List<Note> get notes => _notes;

  noteProvider() {
    fetchNotes();
  }

  Note? get selectedNote => _selectedNote;

  void setSelectedNote (Note note) {
    print('selectedButton pushed');
    _selectedNote = note;
    notifyListeners();
  }

  void clearSelectedNote () {
    _selectedNote = null;
    notifyListeners();
  }

  Future<void> fetchNotes () async {
    print("Fetching notes...");
    final querySnapshot = await FirebaseFirestore.instance.collection('notes').get();
    _notes = querySnapshot.docs.map((doc) => Note.fromDocument(doc)).toList();
    notifyListeners();
  }

  Future<void> addNoteToFirebase(Note note) async {
    await FirebaseFirestore.instance.collection('notes').add(note.toMap());
    fetchNotes();
  }

  Future<void> updateNoteInFirebase(Note note) async {
    try{
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(note.id)
          .update(note.toMap());
      fetchNotes();
    } catch (e) {
      print('Error updateing document: $e');
    }
  }



  void removeNoteById(String id){
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}