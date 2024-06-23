class NoteRelation {
  String id;
  String parentNoteId;
  String childNoteId;

  NoteRelation({
   required this.id,
   required this.parentNoteId,
   required this.childNoteId
  });

  factory NoteRelation.fromMap(Map<String, dynamic> map){
    return NoteRelation(
      id: map['id'],
      parentNoteId: map['parentNoteId'],
        childNoteId: map['childNoteId']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parentNoteId': parentNoteId,
      'childNoteId': childNoteId
    };
  }
}