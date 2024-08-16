// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notas_bex/data/datasources/note_database_helper.dart';
import 'package:notas_bex/data/models/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDatabaseHelper _noteDatabaseHelper = NoteDatabaseHelper();

  int notePriority1 = 0;
  int notePriority2 = 0;
  int notePriority3 = 0;

  List<Note> noteList = [];
  List<Note> noteListFilter = [];

  NoteBloc() : super(NoteInitial()) {
    on<LoadNotesEvent>(_onLoadNotes);

    on<DeleteNoteEvent>(_onDeleteNote);

    on<AddNoteEvent>(_onAddNote);

    on<UpdateNoteEvent>(_onUpdateNote);
  }

  Future<void> _onLoadNotes(
      LoadNotesEvent event, Emitter<NoteState> emit) async {
    print('LoadNotesEvent');
    emit(NoteLoading());
    try {
      final notes = await _noteDatabaseHelper.getNotes();
      noteList = notes;
      noteListFilter = notes;

      notePriority1 = 0;
      notePriority2 = 0;
      notePriority3 = 0;
      for (var note in noteList) {
        if (note.priority == 1) {
          notePriority1++;
        } else if (note.priority == 2) {
          notePriority2++;
        } else {
          notePriority3++;
        }
      }
      emit(NoteLoadSuccess(notes));
    } catch (e) {
      emit(const NoteLoadFailure('Error al cargar las notas'));
    }
  }

  void updateCountNotes() async {
    final notes = await _noteDatabaseHelper.getNotes();
    for (var note in notes) {
      if (note.priority == 1) {
        notePriority1++;
      } else if (note.priority == 2) {
        notePriority2++;
      } else {
        notePriority3++;
      }
    }

    print('updateCountNotes: $notePriority1, $notePriority2, $notePriority3');
    //avisamos actualizar el estado
    add(LoadNotesEvent());
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    try {
      await _noteDatabaseHelper.insertNote(event.note);
      noteList.add(event.note);
      noteListFilter.add(event.note);

      add(LoadNotesEvent()); // Recargar las notas después de agregar una nueva
    } catch (e) {
      emit(const NoteLoadFailure('Error al agregar la nota'));
    }
  }

  Future<void> _onUpdateNote(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    try {
      await _noteDatabaseHelper.updateNote(event.note);
      //actualizar la nota en la lista
      noteList.firstWhere((note) => note.id == event.note.id).copyWith(
            title: event.note.title,
            description: event.note.description,
            content: event.note.content,
            updateDate: event.note.updateDate,
            priority: event.note.priority,
          );

      noteListFilter.firstWhere((note) => note.id == event.note.id).copyWith(
            title: event.note.title,
            description: event.note.description,
            content: event.note.content,
            updateDate: event.note.updateDate,
            priority: event.note.priority,
          );

      add(LoadNotesEvent()); // Recargar las notas después de actualizar
    } catch (e) {
      emit(const NoteLoadFailure('Error al actualizar la nota'));
    }
  }

  Future<void> _onDeleteNote(
      DeleteNoteEvent event, Emitter<NoteState> emit) async {
    try {
      await _noteDatabaseHelper.deleteNote(event.noteId);

      //eliminar la nota de la lista
      noteList.removeWhere((note) => note.id == event.noteId);
      noteListFilter.removeWhere((note) => note.id == event.noteId);

      add(LoadNotesEvent()); // Recargar las notas después de eliminar
    } catch (e) {
      emit(const NoteLoadFailure('Error al eliminar la nota'));
    }
  }
}
