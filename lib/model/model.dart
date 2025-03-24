class NoteModel {
  int id;
  String note;

  NoteModel({required this.id, required this.note});

  factory NoteModel.fromJson(Map<String, dynamic> data) {
    return NoteModel(
      id: data['id'],
      note: data['Notes'],
    );
  }
}
