class NotesModel {
  int? notesId;
  String? noteTitle;
  String? noteContent;
  String? noteImage;
  int? noteUsers;

  NotesModel(
      {this.notesId,
      this.noteTitle,
      this.noteContent,
      this.noteImage,
      this.noteUsers});

  NotesModel.fromJson(Map<String, dynamic> jsonData) {
    notesId = jsonData['notes_id'];
    noteTitle = jsonData['note_title'];
    noteContent = jsonData['note_content'];
    noteImage = jsonData['note_image'];
    noteUsers = jsonData['note_users'];
  }
}
