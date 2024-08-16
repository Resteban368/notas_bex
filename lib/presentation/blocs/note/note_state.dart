part of 'note_bloc.dart';



abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoadSuccess extends NoteState {
  final List<Note> notes;

  const NoteLoadSuccess(this.notes);

  @override
  List<Object> get props => [notes];
}

class NoteLoadFailure extends NoteState {
  final String error;

  const NoteLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
