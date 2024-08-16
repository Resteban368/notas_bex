import 'package:notas_bex/data/datasources/note_database_helper.dart';
import 'package:notas_bex/data/models/note_model.dart';
import 'package:notas_bex/data/models/user_model.dart';

class NoteRepository {
  final NoteDatabaseHelper _databaseHelper = NoteDatabaseHelper();

  // Manejo de Usuarios
  Future<void> registerUser(User user) async {
    await _databaseHelper.registerUser(user);
  }

  Future<User?> getUserByEmail(String email) async {
    return await _databaseHelper.getUserByEmail(email);
  }

  Future<void> updateUser(User user) async {
    await _databaseHelper.updateUser(user);
  }

  // Manejo de Notas
  Future<void> insertNote(Note note) async {
    await _databaseHelper.insertNote(note);
  }

  Future<void> updateNote(Note note) async {
    await _databaseHelper.updateNote(note);
  }

  Future<void> deleteNote(int id) async {
    await _databaseHelper.deleteNote(id);
  }

  Future<List<Note>> getNotes() async {
    return await _databaseHelper.getNotes();
  }
}
